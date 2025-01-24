#!/usr/bin/env bash

cd "$(dirname $0)" || exit 1

export base="$(pwd)"

##################################################
printf "\e[30m not found, but paru found.\n\e[0m" # 透明
printf "\e[31m not found, but paru found.\n\e[0m" # 红色
printf "\e[32m not found, but paru found.\n\e[0m" # 绿色
printf "\e[33m not found, but paru found.\n\e[0m" # 黄色
printf "\e[34m not found, but paru found.\n\e[0m" # 蓝色
printf "\e[35m not found, but paru found.\n\e[0m" # 粉色
printf "\e[36m not found, but paru found.\n\e[0m" # 青色
printf "\e[37m not found, but paru found.\n\e[0m" # 白色
printf "\e[38m not found, but paru found.\n\e[0m" # 米黄色

if ! command -v dnf >/dev/null 2>&1; then
  printf "\e[31m[$0]: pacman is not found, it seems that the system is not archlinux or arch-based distributions. Abort....\e[0m\n"
  exit 1
fi
