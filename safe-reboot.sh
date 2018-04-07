#! /bin/bash

echo "Stopping system services..."
systemctl stop smbd
systemctl stop minio
systemctl stop apache2

echo "Exporting ZFS mounts..."
zpool export tank

echo "Resealing encrypted vaults..."
cryptsetup luksClose /dev/mapper/vault1
cryptsetup luksClose /dev/mapper/vault2
cryptsetup luksClose /dev/mapper/vault3
cryptsetup luksClose /dev/mapper/vault4
cryptsetup luksClose /dev/mapper/vault5
cryptsetup luksClose /dev/mapper/vault6
cryptsetup luksClose /dev/mapper/vault7
cryptsetup luksClose /dev/mapper/vault8
cryptsetup luksClose /dev/mapper/vault9

echo "Done!"
read -p "Reboot the system now? " -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
  reboot
fi
