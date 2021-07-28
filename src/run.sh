#!/usr/bin/env bash
set -Ceu
#---------------------------------------------------------------------------
# AquesTalkPiでラズパイをしゃべらせる。
# CreatedAt: 2021-07-28
#---------------------------------------------------------------------------
Run() {
	THIS="$(realpath "${BASH_SOURCE:-0}")"; HERE="$(dirname "$THIS")"; PARENT="$(dirname "$HERE")"; THIS_NAME="$(basename "$THIS")"; APP_ROOT="$PARENT";
	cd "$HERE"
	PATH_DIR=/home/pi/root/sys/env/tool
	TO=$PATH_DIR/tts/aquestalkpi/20201010-1.1.0
	Test() { $PATH_DIR/AquesTalkPi 漢字も読めます | aplay; }
	[ -f $PATH_DIR/AquesTalkPi ] && { Test; return; }
	Download() {
		wget https://www.a-quest.com/archive/package/aquestalkpi-20201010.tgz?download=1&readed=yes
		mkdir -p "$TO"
		tar xf aquestalkpi-20201010.tgz -C "$TO"
	}
	MakeRunScript() {
		echo '#!/bin/bash' >> $PATH_DIR/AquesTalkPi
		echo "$TO/aquestalkpi/AquesTalkPi \"@\"" >> $PATH_DIR/AquesTalkPi
	}
	Install() {
		# ~/bashrc に export PATH=$PATH:/home/pi/root/sys/env/tool を追記する
	}
	Download
	MakeRunScript
	Test
}
Run "$@"
