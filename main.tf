provider "aws" {
  region = "us-east-1"
}

resource "null_resource" "log_start" {
 provisioner "local-exec" {
    command = <<EOT
        echo "START: $(date)" > terraform_execution.log
        EOT
   
 }

}

resource "aws_instance" "webserver" {
  ami           = "ami-04b4f1a9cf54c11d0"
  instance_type = "t2.micro"
  vpc_security_group_ids = concat([ aws_security_group.public_sg.id],[] )
}

resource "aws_security_group" "public_sg" {
    name = "public_sg"
    description = "Allow port 80 and 22 for web and ssh access"
    

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
  
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
    Name = "Public Security Group"
  }
}


resource "aws_key_pair" "mackey" {
  public_key = file("~/.ssh/id_rsa.pub")

}



resource "null_resource" "base_cmd" {
  # depends_on = [ aws_instance.webserver ]


  provisioner "remote-exec" {

    inline = [
      "sudo touch /tmp/test1.log"
    ]

    connection {
      host        = aws_instance.webserver.public_ip
      private_key = file("~/.ssh/id_rsa")
      user        = "ubuntu"
      type        = "ssh"

    }

  }

}

output "public_ip" {
  value = aws_instance.webserver.public_ip
}

resource "null_resource" "log_stop" {
 provisioner "local-exec" {
    command = <<EOT
        echo "START: $(date)" > terraform_execution.log
        EOT
 }

}