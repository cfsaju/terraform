/* provider "aws" {
  region = "us-east-1"
} 

resource "null_resource" "log_start" {
  provisioner "local-exec" {
    command = <<EOT
        echo "START: $(date)" > terraform_execution.log
        EOT
  }
}


# To create the VPC
module "vpc" {
  source             = "./modules/vpc"
  vpc_name           = "myVPC"
  cidr_block         = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/28"
  availability_zone  = "us-east-1a"
}


output "vpc_id" {
  value = module.vpc.vpc_id
}

# To create the key in AWS using public key for login

resource "aws_key_pair" "mykey" {
  key_name   = "mac-key"
  public_key = file("~/.ssh/id_rsa.pub")
}


module "ec2" {
  depends_on    = [module.vpc]
  source        = "./modules/ec2"
  ami_id        = "ami-04b4f1a9cf54c11d0"
  instance_type = "t2.micro"
  subnet_id     = module.vpc.private_subnet_id
  sec_grp       = aws_security_group.public_sg.id
  ssh_key       = aws_key_pair.mykey.key_name
  no_inst       = 1

}

resource "aws_security_group" "public_sg" {
  name        = "public_sg"
  description = "Allow port 80 and 22 for web and ssh access"
  vpc_id      = module.vpc.vpc_id

  # Allow inbound HTTP (port 80) and SSH (port 22) traffic
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from anywhere

  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP from anywhere
  }

  # Allow all outbound traffic (default)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # All traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Public Security Group"
  }

}

resource "null_resource" "apache_install" {

  depends_on = [module.ec2]

  provisioner "remote-exec" {
    inline = [
      "sudo apt install -y apache2",
      "sudo systemctl start apache2"
    ]

    connection {
      host        = module.ec2.public_ip
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
    }

  }

}

output "ec2_public_ip" {
  value = module.ec2.public_ip

}

resource "null_resource" "log_end" {
  depends_on = [module.vpc]

  provisioner "local-exec" {
    command = <<EOT
        echo "END: $(date)" >> terraform_execution.log
        echo "STATUS: SUCCESS" >> terraform_execution.log
        EOT
  }
}

resource "null_resource" "force_run" {
  provisioner "local-exec" {
    command = "echo 'Only authorised person allowed: '"
  }

  triggers = {

    always_run = timestamp() #Always changes → Forces execution

  }
}

/*
resource "aws_s3_bucket" "s3_bucket" {
  bucket = "saju-terraform-bucket"

  tags = {
    Name = "My Bucket"
    Environment = "Dev"
  }

}
*/