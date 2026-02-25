variable "artifact" {}

source "huaweicloud-ecs" "images" {
  region                      = lookup(var.artifact, "region", "cn-north-4")
  image_name                  = "${var.artifact.image_name}-${formatdate("YYYY-MM-DD-hhmm", timestamp())}"
  flavor                      = lookup(var.artifact, "flavor", "c6.large.2")
  image_description           = lookup(var.artifact, "image_description", "")
  image_type                  = lookup(var.artifact, "image_type", "system")
  image_tags                  = lookup(var.artifact, "image_tags", {})
  wait_image_ready_timeout    = lookup(var.artifact, "wait_image_ready_timeout", "30m")
  availability_zone           = lookup(var.artifact, "availability_zone", "${var.artifact.flavor}a")
  source_image                = var.artifact.source_image
  associate_public_ip_address = lookup(var.artifact, "associate_public_ip_address", true)
  eip_type                    = lookup(var.artifact, "eip_type", "5_bgp")
  eip_bandwidth_size          = lookup(var.artifact, "eip_bandwidth_size", 100)
  user_data_file              = lookup(var.artifact, "user_data_file", "user_data.sh")
  ssh_ip_version              = lookup(var.artifact, "ssh_ip_version", "4")
  vpc_id                      = lookup(var.artifact, "vpc_id", "")
  subnets                     = lookup(var.artifact, "subnets", [])
  security_groups             = lookup(var.artifact, "security_groups", [])
  volume_type                 = lookup(var.artifact, "volume_type", "GPSSD")
  volume_size                 = lookup(var.artifact, "volume_size", "40")
  #  kms_key_id                  = lookup(var.artifact, "kms_key_id", "")
  ssh_username = lookup(var.artifact, "ssh_username", "root")
}

build {
  sources = [
    "source.huaweicloud-ecs.images"
  ]
  provisioner "shell" {
    inline = [
      "sleep 5",
      "yum update -y > /dev/null 2>&1",
      "yum clean all > /dev/null 2>&1",
#      "curl -ksSL https://goldstrike.oss-cn-shanghai.aliyuncs.com/hardening/scripts/huaweicloud-level-protection.sh | bash",
      "curl -k -X GET -m 20 --retry 1 --retry-delay 10 -o /tmp/install_uniagentd_OS.sh https://aom-uniagent-cn-north-4.obs.cn-north-4.myhuaweicloud.com/install_uniagentd_OS.sh > /dev/null 2>&1",
      "bash /tmp/install_uniagentd_OS.sh config",
      "rm -f /tmp/install_uniagentd_OS.sh"
    ]
  }
}
