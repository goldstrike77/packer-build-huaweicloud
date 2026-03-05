#!/bin/sh
groupadd wheel
useradd -u 1000 -G wheel -m -s /bin/bash ecsadmin
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/wheel
chmod 750 /home/ecsadmin
sed -i 's/wheel:x:1000:ecsadmin/wheel:x:1000:ecsadmin,root/' /etc/group
echo "AllowUsers *@198.19.0.0/16 *@10.0.0.0/8" >> /etc/ssh/sshd_config