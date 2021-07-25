resource "aws_instance" "web" {
  ami           = "ami-00399ec92321828f5"
  instance_type = "${var.instance_type}"
  subnet_id     = "${var.subnet_id}"

  tags = {
    Name = "dev-webserver"
  }
}
