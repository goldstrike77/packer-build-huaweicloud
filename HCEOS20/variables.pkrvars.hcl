artifact = {
  region            = "cn-north-4"                                # 区域名称。参考https://console.huaweicloud.com/apiexplorer/#/endpoint/IMS
  image_name        = "goldimage-HCE20"                           # 待创建私有镜像的名称。
  flavor            = "c6.large.2"                                # 云服务器的规格。
  image_description = "Automate Image Builds by HashiCorp Packer" # 待创建私有镜像的描述。
  image_type        = "system"
  image_tags = {
    builder = "packer"
    app     = "infra"
  }
  wait_image_ready_timeout    = "30m"
  availability_zone           = "cn-north-4a"
  source_image                = "7d940784-ac0a-425f-b3fa-8478f1a1df70"
  associate_public_ip_address = true
  eip_type                    = "5_bgp"
  eip_bandwidth_size          = 100
  user_data_file              = "user_data.sh"
  ssh_ip_version              = "4"
  vpc_id                      = "5151944c-111e-45f5-bbfd-a6c5a0274a84"
  subnets                     = ["e0632eb5-ae1d-442a-af34-0c85b7ca9586"]
  security_groups             = ["feb8886c-8a65-4411-a63b-97ab19344f58"]
  volume_type                 = "GPSSD"
  volume_size                 = 40
  ssh_username                = "root"
}