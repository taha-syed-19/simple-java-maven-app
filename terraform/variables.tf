variable "vpc_cidr_block" {
    default = "10.0.0.0/16"
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
    default = "223.233.85.130/32"
}
variable "instance_type" {
    default = "t2.micro"
}
