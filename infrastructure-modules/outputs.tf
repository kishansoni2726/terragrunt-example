output "vpc_id" {
  value = aws_vpc.main.id
}

output "EIP" {
  value = aws_eip.nat_eip.address
}

