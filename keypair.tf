resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = file(var.public_key)
}