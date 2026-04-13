#!/usr/bin/env bash

# configPath="/etc/nixos/hardware-configuration.nix"
# Backup current hardware-configuration.nix and make new one
# sudo mv configPath /etc/nixos/hardware-configuration.nix.bak && nixos-generate-config

# Search and delete
# pattern="boot.initrd.luks.devices"
# lineLocation=$(sed -n "/${pattern}/{=;q;}" "$configPath")
# if ! [ -z "$lineLocation" ]; then
# sed "/${pattern}/c\\
# " "$configPath"


# Lsblk ouput
# lsblk -rno NAME,PKNAME,UUID,FSTYPE | awk '
# $4 == "crypto_LUKS" {
#     luks_uuid[$1] = $3
# }
# {
#     parent = $2
#     if (parent in luks_uuid) {
#         print luks_uuid[parent]
#         print $1
#     }
# }
# ' > /tmp/luksConf.txt

# Formatting and replacing

# fi

# Rebuild

display=$(grep 'mkHost {' ./flake.nix | awk '{print $1}' | nl -w3 -s': ')
confn=$(echo "$display" | awk 'END {print NR}')
echo "Choose config between: (Press 1-${confn})"
echo "${display}"
read -p "Choice: " user_choice
while ! [[ $user_choice -ge 1 && $user_choice -le $confn ]]; do
  echo "Please try again."
  read -p "Choice: " user_choice
done

