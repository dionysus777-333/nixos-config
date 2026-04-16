#!/usr/bin/env bash
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
cd nixos-config
sudo nixos-install --flake .#${userchoiceR}
sudo mkdir -p /mnt/home/user
sudo mv nixos-config /mnt/home/user/
