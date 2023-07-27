output "aws_availability_zones" {
  value = data.aws_availability_zones.available.names
}
#output "public_subnets_1" {
#  value = aws_subnet.public_subnets_1
#}
#output "public_subnets_2" {
#  value = aws_subnet.public_subnets_2
#}
#output "privet_subnets_1" {
#  value = aws_subnet.private_subnets_1
#}
#output "privet_subnets_2" {
#  value = aws_subnet.private_subnets_2
#}
output "private_subnets_1_id" {
  value = aws_subnet.private_subnets_1.*.id
}
output "public_subnets_1_id" {
  value = aws_subnet.public_subnets_1.*.id
}
output "private_subnets_2_id" {
  value = aws_subnet.private_subnets_2.*.id
}
output "public_subnets_2_id" {
  value = aws_subnet.public_subnets_2.*.id
}