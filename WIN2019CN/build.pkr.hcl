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
  source_image                = lookup(var.artifact, "source_image", "049807c9-5d08-442a-9439-8e68c81872ed")
  associate_public_ip_address = lookup(var.artifact, "associate_public_ip_address", true)
  eip_type                    = lookup(var.artifact, "eip_type", "5_bgp")
  eip_bandwidth_size          = lookup(var.artifact, "eip_bandwidth_size", 100)
  user_data_file              = lookup(var.artifact, "user_data_file", "user_data.ps1")
  vpc_id                      = lookup(var.artifact, "vpc_id", "")
  subnets                     = lookup(var.artifact, "subnets", [])
  security_groups             = lookup(var.artifact, "security_groups", [])
  volume_type                 = lookup(var.artifact, "volume_type", "GPSSD")
  volume_size                 = lookup(var.artifact, "volume_size", "100")
  communicator                = lookup(var.artifact, "communicator", "winrm")
  winrm_port                  = lookup(var.artifact, "winrm_port", 5985)
  winrm_username              = lookup(var.artifact, "winrm_username", "administrator")

}

build {
  sources = [
    "source.huaweicloud-ecs.images"
  ]
  #provisioner "powershell" {
  #  elevated_user     = "SYSTEM"
  #  elevated_password = ""
  #  execution_policy  = "unrestricted"
  #  inline = [
  #    "Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force",
  #    "Install-Module -Name PSWindowsUpdate -RequiredVersion 2.2.1.5 -Force",
  #    "Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -AutoReboot"
  #  ]
  #}
  #provisioner "windows-restart" {
  #  restart_timeout = "20m"
  #}
}