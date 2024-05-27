output "public_ip" {
  value = module.bastion.public_ip
}
output "private_ip" {
  value = module.bastion.private_ip
}