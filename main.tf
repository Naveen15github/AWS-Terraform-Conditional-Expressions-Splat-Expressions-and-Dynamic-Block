resource "random_string" "name_suffix" {
  length  = 5
  upper   = false
  special = false
}

resource "random_integer" "instance_index" {
  min = 1
  max = 100
}

resource "random_id" "unique_id" {
  byte_length = 4
}

resource "aws_instance" "conditional_example" {
  ami = data.aws_ami.amazon_linux.id

  instance_type = var.environment == "prod" ? "t3.large" : "t2.micro"

  tags = {
    Name        = "ec2-${var.environment}-${random_string.name_suffix.result}"
    Index       = tostring(random_integer.instance_index.result)
    UniqueID    = random_id.unique_id.hex
    Environment = var.environment
  }
}
