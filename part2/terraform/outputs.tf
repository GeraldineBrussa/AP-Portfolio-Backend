output "jumphost_ip" {
    value = aws_instance.jumphost.public_ip
}

output "rds_dns" {
    value = module.db.db_instance_endpoint
}