output "db_sg" {
  value = module.db.sg_id
}
output "backend_sg" {
  value = module.backend.sg_id
}
output "frontend_sg" {
  value = module.frontend.sg_id
}
output "ansible_sg" {
  value = module.ansible.sg_id
}
output "bastion_sg" {
  value = module.bastion.sg_id
}
