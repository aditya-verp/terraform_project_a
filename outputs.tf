output "bastion_private_key" {
  description = "Private key for SSH access to the Bastion Host"
  value       = tls_private_key.bastion_key.private_key_pem
  sensitive   = true
}

# terraform output -raw bastion_private_key > bastion_key.pem

