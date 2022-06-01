resource "random_string" "id_suffix" {
  length  = 4
  special = false
  upper   = false
}

locals {
  # use this variable as prefix for all resource names. This avoids conflicts with globally unique resources (all resources with a hostname)
  env       = "${terraform.workspace}-${random_string.id_suffix.result}"
  env_human = terraform.workspace

  cluster_domain = "superhero.com"

  env_config = {

    dev = {
      subnet_network_zone        = "eu-central"
      subnet_type                = "cloud"
      network_ip_range           = "10.0.0.0/16"
      subnet_ip_ranges           = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
      k8s_master_instance_count  = "3"
      k8s_master_server_type     = "cx41"
      k8s_master_image           = "ubuntu-20.04"
      k8s_master_disk_format     = "ext4"
      k8s_master_disk_size       = "100"
      k8s_master_location        = "nbg1"
      k8s_master_ssh_keys        = ["hertzner"]
      common_server_type         = "cx11"
      common_image               = "ubuntu-20.04"
      common_disk_format         = "ext4"
      common_disk_size           = "20"
      common_location            = "nbg1"
      common_ssh_keys            = ["hertzner"]
      common_instance_count      = "1"
      pg_backend_attach_firewall = true
      k8s_master_attach_firewall = true
      bastion_attach_firewall    = true
      bastion_firewall_rules = [
        {
          direction  = "in"
          protocol   = "tcp"
          port       = "22"
          source_ips = ["0.0.0.0/0"]
        },
      ]
      pg_backend_firewall_rules = [
        {
          direction  = "in"
          protocol   = "tcp"
          port       = "22"
          source_ips = ["0.0.0.0/0"]
        },
        {
          direction       = "out"
          protocol        = "tcp"
          port            = "53"
          destination_ips = ["0.0.0.0/0"]
        },
        {
          direction       = "out"
          protocol        = "udp"
          port            = "53"
          destination_ips = ["0.0.0.0/0"]
        },
        {
          direction  = "in"
          protocol   = "tcp"
          port       = "5432"
          source_ips = ["0.0.0.0/0"]
        },
      ]
      k8s_master_firewall_rules = [
        {
          direction  = "in"
          protocol   = "icmp"
          source_ips = ["0.0.0.0/0"]
        },
        {
          direction  = "in"
          protocol   = "tcp"
          port       = "22"
          source_ips = ["0.0.0.0/0"]
        },
        {
          direction       = "out"
          protocol        = "icmp"
          destination_ips = ["0.0.0.0/0"]
        },
        {
          direction       = "out"
          protocol        = "tcp"
          port            = "53"
          destination_ips = ["0.0.0.0/0"]
        },
        {
          direction       = "out"
          protocol        = "udp"
          port            = "53"
          destination_ips = ["0.0.0.0/0"]
        },
      ]
    }
    prd = {
      subnet_network_zone        = "eu-central"
      subnet_type                = "cloud"
      network_ip_range           = "172.16.0.0/16"
      subnet_ip_ranges           = ["172.16.1.0/24", "172.16.2.0/24", "172.16.3.0/24"]
      k8s_master_instance_count  = "3"
      k8s_master_server_type     = "cx41"
      k8s_master_image           = "ubuntu-20.04"
      k8s_master_disk_format     = "ext4"
      k8s_master_disk_size       = "100"
      k8s_master_location        = "nbg1"
      k8s_master_ssh_keys        = ["hertzner"]
      common_server_type         = "cx11"
      common_server_type         = "cx11"
      common_image               = "ubuntu-20.04"
      common_disk_format         = "ext4"
      common_disk_size           = "20"
      common_location            = "nbg1"
      common_ssh_keys            = ["hertzner"]
      common_instance_count      = "1"
      pg_backend_attach_firewall = true
      k8s_master_attach_firewall = true
      bastion_attach_firewall    = true
      bastion_firewall_rules = [
        {
          direction  = "in"
          protocol   = "tcp"
          port       = "22"
          source_ips = ["0.0.0.0/0"]
        },
      ]
      pg_backend_firewall_rules = [
        {
          direction  = "in"
          protocol   = "tcp"
          port       = "22"
          source_ips = ["0.0.0.0/0"]
        },
        {
          direction       = "out"
          protocol        = "tcp"
          port            = "53"
          destination_ips = ["0.0.0.0/0"]
        },
        {
          direction       = "out"
          protocol        = "udp"
          port            = "53"
          destination_ips = ["0.0.0.0/0"]
        },
        {
          direction  = "in"
          protocol   = "tcp"
          port       = "5432"
          source_ips = ["0.0.0.0/0"]
        },
      ]
      k8s_master_firewall_rules = [
        {
          direction  = "in"
          protocol   = "icmp"
          source_ips = ["0.0.0.0/0"]
        },
        {
          direction  = "in"
          protocol   = "tcp"
          port       = "22"
          source_ips = ["0.0.0.0/0"]
        },
        {
          direction       = "out"
          protocol        = "icmp"
          destination_ips = ["0.0.0.0/0"]
        },
        {
          direction       = "out"
          protocol        = "tcp"
          port            = "53"
          destination_ips = ["0.0.0.0/0"]
        },
        {
          direction       = "out"
          protocol        = "udp"
          port            = "53"
          destination_ips = ["0.0.0.0/0"]
        },
      ]
    }

    stg = {
      subnet_network_zone        = "eu-central"
      subnet_type                = "cloud"
      network_ip_range           = "192.168.0.0/16"
      subnet_ip_ranges           = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
      k8s_master_instance_count  = "3"
      k8s_master_server_type     = "cx41"
      k8s_master_image           = "ubuntu-20.04"
      k8s_master_disk_format     = "ext4"
      k8s_master_disk_size       = "100"
      k8s_master_location        = "nbg1"
      k8s_master_ssh_keys        = ["hertzner"]
      common_server_type         = "cx11"
      common_server_type         = "cx11"
      common_image               = "ubuntu-20.04"
      common_disk_format         = "ext4"
      common_disk_size           = "20"
      common_location            = "nbg1"
      common_ssh_keys            = ["hertzner"]
      common_instance_count      = "1"
      pg_backend_attach_firewall = true
      k8s_master_attach_firewall = true
      bastion_attach_firewall    = true
      bastion_firewall_rules = [
        {
          direction  = "in"
          protocol   = "tcp"
          port       = "22"
          source_ips = ["0.0.0.0/0"]
        },
      ]
      pg_backend_firewall_rules = [
        {
          direction  = "in"
          protocol   = "tcp"
          port       = "22"
          source_ips = ["0.0.0.0/0"]
        },
        {
          direction       = "out"
          protocol        = "tcp"
          port            = "53"
          destination_ips = ["0.0.0.0/0"]
        },
        {
          direction       = "out"
          protocol        = "udp"
          port            = "53"
          destination_ips = ["0.0.0.0/0"]
        },
        {
          direction  = "in"
          protocol   = "tcp"
          port       = "5432"
          source_ips = ["0.0.0.0/0"]
        },
      ]
      k8s_master_firewall_rules = [
        {
          direction  = "in"
          protocol   = "icmp"
          source_ips = ["0.0.0.0/0"]
        },
        {
          direction  = "in"
          protocol   = "tcp"
          port       = "22"
          source_ips = ["0.0.0.0/0"]
        },
        {
          direction       = "out"
          protocol        = "icmp"
          destination_ips = ["0.0.0.0/0"]
        },
        {
          direction       = "out"
          protocol        = "tcp"
          port            = "53"
          destination_ips = ["0.0.0.0/0"]
        },
        {
          direction       = "out"
          protocol        = "udp"
          port            = "53"
          destination_ips = ["0.0.0.0/0"]
        },
      ]
    }
  }

  config = merge(lookup(local.env_config, terraform.workspace, {}))

  standard_tags = {
    "env"         = local.env
    "project"     = "superhero"
    "github-repo" = "terraform-hertzner-k8s"
    "github-org"  = "aeternity"
  }

  tag_query = join(",\n", [for key in keys(local.standard_tags) : <<JSON
    {
      "Key": "${key}", 
      "Values": ["${lookup(local.standard_tags, key)}"]
    }
  JSON
  ])
}
