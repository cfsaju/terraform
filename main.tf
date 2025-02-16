provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["/Users/sajufrancis/.aws/credentials"]
}


resource "aws_iam_user" "test_user1" {
  name = "test_user1"

  /* tags = merge(
  
    data.aws_iam_user.test_user1.tags,
      {environment = "dev",
      purpose     = "Boat Testing" }
    
)
*/

}

/*
# Merge function to update/add  the tags of the user
 data "aws_iam_user" "test_user1" {
  user_name = "test_user1"

}
*/


/*
resource "null_resource" "log_start" {
  provisioner "local-exec" {
    command = <<EOT
        echo "START: $(date)" > terraform_execution.log
        echo "Deploying: ${var.deployment_version}"
        EOT
  }

  triggers = {
    version = var.deployment_version
  }
}


resource "aws_iam_user" "listusers" {
  for_each = toset(var.list_users)
  name     = each.value
}

resource "aws_iam_user" "countusers" {
  count = 5
  name  = "user-${count.index + 1}"

  tags = {
    Specialuser = count.index == 1 ? "Super User" : "Operator"

  }

} 

resource "aws_iam_user" "mapusers" {
  for_each = var.map_users
  name     = each.value

  tags = {
    tag_name = lookup(var.map_users, each.key, "Test User")
  }

}

resource "aws_vpc" "myvpc" {
  cidr_block = lookup(var.vpc_cidr, "test", "10.0.0.0/24")

}

# Example of using dynamic Block

resource "aws_security_group" "public_sg" {
  name        = "dynamic-sg"
  description = "Example security group"

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

}

/*
output "user_names" {

  value = [for user in aws_iam_user.countusers : user.name]

}

# EC2 , SG, creation block
/*
resource "aws_key_pair" "mackey" {
  public_key = file("~/.ssh/id_rsa.pub")

}

resource "aws_instance" "webserver" {
  ami                    = "ami-04b4f1a9cf54c11d0"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  key_name = aws_key_pair.mackey.key_name
  # vpc_security_group_ids = concat([aws_security_group.public_sg.id], [])
}

resource "aws_security_group" "public_sg" {
  name        = "public_sg"
  description = "Allow port 80 and 22 for web and ssh access"


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Public Security Group"
  }
}

# Example of using Dependency

resource "null_resource" "base_cmd" {
  depends_on = [ aws_instance.webserver ]

# Example of using remote provisioner

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



# Example of using null resource and local provisioner 

resource "null_resource" "log_stop" {
  provisioner "local-exec" {
    command = <<EOT
        echo "START: $(date)" > terraform_execution.log
        EOT
  }

}
# Example of using locals

locals {
  app_name  = "web-app"
  env       = "dev"
  full_name = "${local.app_name}-${local.env}"
}

resource "aws_s3_bucket" "test_bucket" {
  bucket = local.full_name

}
*/
