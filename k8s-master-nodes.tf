module "k8s-master-nodes" {
  source          = "./modules/tf_hetzner_servers"
  network_id      = module.network.network_id[0]
  instance_count  = local.config.k8s_master_instance_count
  name            = "${local.env}-k8s-master-node"
  server_type     = local.config.k8s_master_server_type
  labels          = local.standard_tags
  image           = local.config.k8s_master_image
  disk_format     = local.config.k8s_master_disk_format
  disk_size       = local.config.k8s_master_disk_size
  ssh_keys        = local.config.k8s_master_ssh_keys
  attach_firewall = true
  attach_to_lb = true
  load_balancer_id = module.k8s-control-plane-lb.lb_id
  cidr_prefix = module.network.subnet_ip_range
  subnet_ids = module.network.subnet_id
  firewall_rules = [
    {
      direction  = "in"
      protocol   = "tcp"
      port       = "any"
      source_ips = [module.network.network_ip_range[0]]
    },
    {
      direction  = "in"
      protocol   = "udp"
      port       = "any"
      source_ips = [module.network.network_ip_range[0]]
    },
    {
      direction  = "in"
      protocol   = "icmp"
      source_ips = [module.network.network_ip_range[0]]
    },
    {
      direction  = "in"
      protocol   = "tcp"
      port       = "6443"
      source_ips = ["0.0.0.0/0"]
    },
    {
      direction  = "in"
      protocol   = "tcp"
      port       = "22"
      source_ips = [module.network.network_ip_range[0]]
    },
    {
      direction       = "out"
      protocol        = "tcp"
      port            = "any"
      destination_ips = ["0.0.0.0/0"]
    },
    {
      direction       = "out"
      protocol        = "udp"
      port            = "any"
      destination_ips = ["0.0.0.0/0"]
    },
  ]
}

