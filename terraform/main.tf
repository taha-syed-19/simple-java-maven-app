provider "aws" {
    region = "ap-south-1"
}

variable "vpc_cidr_block" {
    default = "10.0.0.0./16"
}
variable "subnet_cidr_block" {
    default = "10.0.1.0/24"
}
variable "availability_zone" {
    default = "ap-south-1a"
}
variable "env_prefix" {
    default = "dev"
}
variable "my_ip" {
    default = "223.233.85.130/24"
}
variable "instance_type" {
    default = "t2.micro"
}




resource "aws_vpc" "my_vpc" {
    cidr_block = var.vpc_cidr_block
    tags = {
        Name: "${var.env_prefix}-vpc"
    }
}

resource "aws_subnet" "my_subnet-1" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.subnet_cidr_block
    availability_zone = var.availability_zone
    tags = {
      Name: "${var.env_prefix}-subnet-1"
    }
}

resource "aws_internet_gateway" "my-app-IGW" {
    vpc_id = aws_vpc.my_vpc.id

    tags = {
      Name: "${var.env_prefix}-IGW"
    }
  
}

resource "aws_default_route_table" "my-app-main-rtb" {
    default_route_table_id = aws_vpc.my_vpc.default_route_table_id 
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my-app-IGW.id
    }

    tags = {
      Name: "${var.env_prefix}-rtb"
    }
  
}

resource "aws_default_security_group" "default-sg" {
    vpc_id = aws_vpc.my_vpc.id

    ingress  {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [var.my_ip]

    }

    ingress  {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }

    egress  {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        prefix_list_ids = []

    }

    tags = {
      Name: "${var.env_prefix}-default-sg"
    }
  
}


data "aws_ami" "latest-amazon-linux-image" {
    most_recent = true
    owners = [ "amazon" ]
    filter {
        name = "name"
        values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    } 

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    } 
}



output "ec2_public_ip" {
    value = aws_instance.my-app-instance.public_ip
  
}



resource "aws_instance" "my-app-instance" {
    ami = data.aws_ami.latest-amazon-linux-image.id
    instance_type = var.instance_type
    subnet_id = aws_subnet.my_subnet-1.id
    vpc_security_group_ids = [ aws_default_security_group.default-sg.id ]
    availability_zone = var.availability_zone
    associate_public_ip_address = true
    key_name = "myapp-key-pair"

    user_data = file("entry-script.sh")

    tags = {
      Name = "${var.env_prefix}-server"
    }
  
}