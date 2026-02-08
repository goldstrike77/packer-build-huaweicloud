variable "artifact" {}

source "huaweicloud-ecs" "images" {
  region                      = var.artifact.region
  image_name                  = "${var.artifact.image_name}-${formatdate("YYYY-MM-DD-hhmm", timestamp())}"
  flavor                      = var.artifact.flavor
  image_description           = lookup(var.artifact, "image_description", "")
  image_type                  = lookup(var.artifact, "image_type", "system")
  image_tags                  = lookup(var.artifact, "image_tags", {})
  wait_image_ready_timeout    = lookup(var.artifact, "wait_image_ready_timeout", "30m")
  availability_zone           = lookup(var.artifact, "availability_zone", "${var.artifact.flavor}a")
  source_image                = var.artifact.source_image
  associate_public_ip_address = lookup(var.artifact, "associate_public_ip_address", true)
  eip_type                    = lookup(var.artifact, "eip_type", "5_bgp")
  eip_bandwidth_size          = lookup(var.artifact, "eip_bandwidth_size", 100)
  ssh_ip_version              = lookup(var.artifact, "ssh_ip_version", "4")
  vpc_id                      = lookup(var.artifact, "vpc_id", "")
  subnets                     = lookup(var.artifact, "subnets", [])
  security_groups             = lookup(var.artifact, "security_groups", [])
  volume_type                 = lookup(var.artifact, "volume_type", "GPSSD")
  volume_size                 = lookup(var.artifact, "volume_size", "40")
  kms_key_id                  = lookup(var.artifact, "kms_key_id", "")
  ssh_username                = var.artifact.ssh_username
}

build {
  sources = [
    "source.huaweicloud-ecs.images"
  ]

  provisioner "shell" {
    inline = [
      "yum update -y",
      "yum clean all"
    ]
  }
}
