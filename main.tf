provider "aws" {
  region     = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_instance" "demo" {
  ami           = "ami-0c2b8ca1dad447f8a"  # Amazon Linux 2 (for us-east-1)
  instance_type = "t2.micro"

  tags = {
    Name = "TerraformDemo"
  }
}
