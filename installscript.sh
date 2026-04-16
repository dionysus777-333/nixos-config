#!/usr/bin/env bash
# set -euo pipefail
# mkdir -p /mnt/user/home && cd /mnt/user/home
# git clone https://github.com/dionysus777-333/nixos-config || {
#   echo "Failed to clone repo"
#   exit 1
# }
# TOTAL_RAM=$(free -m | awk '/^Mem:/{print $2}')
# if [ "$TOTAL_RAM" -lt 2048 ]; then
#     SWAP_SIZE=$((TOTAL_RAM * 2))
#   else 
#     SWAP_SIZE=$(( TOTAL_RAM < 8192 ? TOTAL_RAM : 8192 ))
# fi
display=$(grep 'mkHost {' ./flake.nix | awk '{print $1}' | nl -w3 -s': ')
confn=$(echo "$display" | awk 'END {print NR}')
echo "Choose config between: (Press 1-${confn})"
echo "${display}"
read -p "Choice: " user_choice
while ! [[ $user_choice -ge 1 && $user_choice -le $confn ]]; do
  echo "Please try again."
  read -p "Choice: " user_choice
done
userchoiceR=$(grep 'mkHost {' ./flake.nix | awk '{print $1}' | nl -w3 -s': ' | grep "${user_choice}" | cut -d':' -f2- )

# retry=false
# while true; do
#   lsblk -o NAME,SIZE,MODEL
#   echo 'Type the name of the drive you would like to install on. (the part after /dev/)'
#   echo 'THIS WILL ERASE THE DRIVE!'
#   read -p "Name: " driveN
#   if [[ ! -b /dev/$driveN ]]; then
#     echo "/dev/$driveN is not a valid block device."
#     continue
#   fi
#   read -p "Re-enter device name to confirm: " confirmDrive
#   [[ "$driveN" != "$confirmDrive" ]] && continue
#   lsblk -o NAME,SIZE,MODEL /dev/$driveN
#   echo "You are about to ERASE /dev/$driveN"
#   read -p "Type ERASE to continue: " confirm
#   if [[ "$confirm" != "ERASE" ]]; then
#     echo "Aborted."
#     continue
#   fi
#   if [[ "$driveN" == *"nvme"* ]]; then
#     part_prefix="p"
#   else
#     part_prefix=""
#   fi
#   sudo sgdisk -o /dev/$driveN
#   sudo sgdisk -n 1:0:+512M -t 1:ef00 -c 1:"BOOT" /dev/$driveN
#   sudo sgdisk -n 2:0:+"${SWAP_SIZE}M" -t 2:8200 -c 2:"cryptswap" /dev/$driveN
#   sudo sgdisk -n 3:0:0 -t 3:8300 -c 3:"cryptroot" /dev/$driveN
#   echo 'Please enter the password you would like to use for encryption.'
#   read -s -p "Password: " pass
#   echo
#   # 3. Encrypt Partitions
#   # Root Partition
#   echo -n "$pass" | sudo cryptsetup luksFormat --batch-mode "/dev/${driveN}${part_prefix}3" -
#   echo -n "$pass" | sudo cryptsetup luksOpen "/dev/${driveN}${part_prefix}3" root
# 
#   # Swap Partition (Using the same password for convenience)
#   echo -n "$pass" | sudo cryptsetup luksFormat --batch-mode "/dev/${driveN}${part_prefix}2" -
#   echo -n "$pass" | sudo cryptsetup luksOpen "/dev/${driveN}${part_prefix}2" swap
# 
#   sudo mkfs.vfat -F 32 -n "BOOT" "/dev/${driveN}${part_prefix}1"
#   sudo mkfs.ext4 /dev/mapper/root
#   sudo mkswap /dev/mapper/swap
# 
#   lsblk -o NAME,SIZE,LABEL,PARTLABEL,TYPE,FSTYPE /dev/$driveN
#   while true; do
#     echo 'Type YES to confirm or NO to retry'
#     read user_confirm
#     if [[ $user_confirm == "YES" ]]; then
#       retry=false
#       break
#     elif [[ $user_confirm == "NO" ]]; then
#       sudo wipefs -a /dev/$driveN
#       sudo cryptsetup close root || true
#       sudo cryptsetup close swap || true
#       retry=true
#       break
#     fi
#   done
#   if $retry; then
#     continue
#   fi
#   break
# done
# 
# # Mount root
# sudo mount /dev/mapper/root /mnt
# # Boot
# mkdir -p /mnt/boot
# sudo mount /dev/${driveN}${part_prefix}1 /mnt/boot
# # Swap
# sudo swapon /dev/mapper/swap

cd nixos-config
sudo nixos-install --flake .#${userchoiceR}
sudo mkdir -p /mnt/home/user
sudo mv nixos-config /mnt/home/user/
