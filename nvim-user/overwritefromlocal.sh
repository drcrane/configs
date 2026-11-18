#!/bin/sh
set -e
#[ -d nvim ] && rm -r nvim
#cp -r ~/.config/nvim .

if [ ! -d nvim ] ; then
	echo "Directory not found, cannot continue" 1>&2
	exit 1
fi
CONFIGDIR="${HOME}/.config"
# Directory nvim/lua/user/
FILES="cmp.lua colorscheme.lua commands.lua luatab.lua options.lua plugins.lua \
	remap.lua remember.lua statusline.lua lsp/init.lua lspsignature.lua llm.lua \
	treesitter.lua todolist/init.lua"
set -- ${FILES}
while [ -n "$1" ]
do
	cp "${CONFIGDIR}/nvim/lua/user/$1" "nvim/lua/user/$1"
	shift
done
cp ${CONFIGDIR}/nvim/init.lua nvim/init.lua
cp ${CONFIGDIR}/nvim/colors/obsidian.vim nvim/colors/obsidian.vim
cp ${CONFIGDIR}/nvim/colors/gruvbox.vim nvim/colors/gruvbox.vim

