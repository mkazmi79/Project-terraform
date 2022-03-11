output "aws_instance" {
    value = aws_instance.toronto.id  
}

output "aws_vpc" {
  value = aws_vpc.vpc-tor.id  
}