variable "region" {
  default = "ap-south-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami" {
  default = "ami-0f5ee92e2d63afc18" # Amazon Linux/Ubuntu (Mumbai)
}

variable "bucket_name" {
  default = "anjli-terraform-bucket-12345"
}
