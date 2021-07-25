resource "aws_instance" "web" {
  count         = "${var.ec2_count}"
  ami           = "ami-00399ec92321828f5"
  instance_type = "${var.instance_type}"
  subnet_id     = "${var.subnet_id}"

  tags = {
    Name = "dev-webserver"
  }
}
