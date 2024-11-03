#!/usr/bin/env bash
source <(curl -s https://raw.githubusercontent.com/tdsf/Proxmox/main/misc/build.func)
# Copyright (c) 2021-2024 tteck
# Author: tteck
# Co-Author: havardthom
# License: MIT
# https://github.com/tdsf/Proxmox/raw/main/LICENSE

function header_info {
clear
cat <<"EOF"     
    _   _______   ____  ______     __
   / | / /__  /  / __ )/ ____/__  / /_
  /  |/ /  / /  / __  / / __/ _ \/ __/
 / /|  /  / /__/ /_/ / /_/ /  __/ /_
/_/ |_/  /____/_____/\____/\___/\__/

EOF
}
header_info
echo -e "Loading..."
APP="NZBGet"
var_disk="4"
var_cpu="2"
var_ram="2048"
var_os="debian"
var_version="12"
variables
color
catch_errors

function default_settings() {
  CT_TYPE="1"
  PW=""
  CT_ID=$NEXTID
  HN=$NSAPP
  DISK_SIZE="$var_disk"
  CORE_COUNT="$var_cpu"
  RAM_SIZE="$var_ram"
  BRG="vmbr0"
  NET="dhcp"
  GATE=""
  APT_CACHER=""
  APT_CACHER_IP=""
  DISABLEIP6="no"
  MTU=""
  SD=""
  NS=""
  MAC=""
  VLAN=""
  SSH="no"
  VERB="no"
  echo_default
}

function update_script() {
header_info
if [[ ! -f /lib/systemd/system/nzbget.service ]]; then msg_error "No ${APP} Installation Found!"; exit; fi
msg_info "Updating $APP LXC"
apt-get update &>/dev/null
apt-get -y upgrade &>/dev/null
msg_ok "Updated $APP LXC"
exit
}

start
build_container
description

msg_ok "Completed Successfully!\n"
echo -e "${APP} should be reachable by going to the following URL.
         ${BL}http://${IP}:6789${CL} \n"