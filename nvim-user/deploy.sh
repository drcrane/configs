#!/bin/sh
set -e
#set -x
CONFIG_DIR=~/.config/nvim
if [ ! -d nvim-user ] ; then
	echo "Please execute from the root of the project"
	exit 1
fi
if [ ! -d "${CONFIG_DIR}" ] ; then
	mkdir -p "${CONFIG_DIR}"
fi
cp -r nvim-user/nvim/* "${CONFIG_DIR}"

if [ "X${USER}" = 'Xroot' ] ; then
	echo "TODO: make this select the red status line and only use simple NVIM configuration"
#	sed -i 's/^\(colorscheme [0-9a-zA-Z]*\)$/\1_root/' ~/.vim/vimrc
fi

if [ ! -f "${HOME}/.local/bin/vi" ] ; then
	NVIM_LOC="$(which nvim)"
	if [ -z "${NVIM_LOC}" ] ; then
		echo "nvim not found!"
		exit 1
	fi
	if [ -d "${HOME}/.local/bin" ] ; then
		cd "${HOME}/.local/bin"
		ln -s "${NVIM_LOC}" vi
	fi
fi
