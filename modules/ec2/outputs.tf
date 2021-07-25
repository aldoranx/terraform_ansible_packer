output "public_ip" {
    value = aws_instance.web.public_ip
    description = "The public Ip of the Web Server"
  
}