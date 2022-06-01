module "pg-backend-node" {
  source         = "./modules/tf_hertzner_servers"
  network_id     = module.network.network_id[0]
  instance_count = local.config.common_instance_count
  name           = "pg-backend-${local.env}"
  server_type    = local.config.common_server_type
  labels         = local.standard_tags
  image          = local.config.common_image
  disk_format    = local.config.common_disk_format
  disk_size      = local.config.common_disk_size
  ssh_keys       = local.config.common_ssh_keys
  attach_firewall = local.config.pg_backend_attach_firewall
  firewall_rules = local.config.pg_backend_firewall_rules
}