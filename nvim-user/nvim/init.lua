require "user.options"
require "user.remap"
require "user.plugins"
require "user.colorscheme"
require "user.statusline"
require "user.cmp"
require "user.lsp"
require "user.commands"
require "user.remember"
require "user.lspsignature"
require "user.treesitter"
require("user.todolist").setup({ target_file = "~/todo.md" })
vim.keymap.set("n", "<leader>td", ":Td<CR>", { silent = true })

require("user.luatab").setup({})

