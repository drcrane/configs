local options = {
  backup = false,                          -- creates a backup file
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  cmdheight = 1,                           -- more space in the neovim command line for displaying messages
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0,                        -- so that `` is visible in markdown files
  fileencoding = "utf-8",                  -- the encoding written to a file
  hlsearch = true,                         -- highlight all matches on previous search pattern
  ignorecase = true,                       -- ignore case in search patterns
  mouse = {},                              -- no mouse to be used in neovim
  pumheight = 10,                          -- pop up menu height
  showmode = true,                         -- this shows things like -- INSERT --
  showtabline = 1,                         -- show tabs (sometimes?)
  smartcase = true,                        -- smart case
  smartindent = false,                     -- make indenting smarter again
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  swapfile = false,                        -- creates a swapfile
  termguicolors = true,                    -- set term gui colors (most terminals support this)
  timeoutlen = 1000,                       -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                         -- enable persistent undo
  updatetime = 300,                        -- faster completion (4000ms default)
  writebackup = false,                     -- if a file is being edited by another program
	                                       -- (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = false,                       -- dont convert tabs to spaces
--  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
  tabstop = 4,                             -- one tab is n spaces
  shiftwidth = 4,                          -- one tab input moves only one tab... weird?
  softtabstop = 4,
  cursorline = true,                       -- highlight the current line
  number = true,                           -- set numbered lines
  relativenumber = false,                  -- set relative numbered lines
  numberwidth = 4,                         -- set number column width to 2 {default 4}
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  wrap = true,                             -- display lines as one long line
  scrolloff = 8,                           -- is one of my fav
  sidescrolloff = 8,
  guifont = "monospace:h17",               -- the font used in graphical neovim applications
  guicursor = "i:block",
  colorcolumn = "80"
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work
vim.cmd [[set statusline=%!v:lua.require'user.statusline'.statusline()]]

-- does not work
-- vim.opt.statusline = require('user.statusline').statusline;

vim.api.nvim_create_augroup("bufcheck", { clear = true });

-- Enable OSC52 to allow copy and paste over SSH to and from system clipboard
vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
    ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
  },
}

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
--		vim.api.nvim_buf_set_option(0, 'softtabstop', 4);
		vim.bo.softtabstop = 4;
--		vim.api.nvim_buf_set_option(0, 'shiftwidth', 4);
		vim.bo.shiftwidth = 4;
--		vim.api.nvim_buf_set_option(0, 'expandtab', true);
		vim.bo.expandtab = true;
		vim.cmd [[setlocal spell spelllang=en_gb]]
	end
});

vim.api.nvim_create_autocmd("FileType", {
	pattern = "c,cpp",
	callback = function()
		print("this is a c or cpp file")
	end
});

-- start nvim with specific filetype like this
-- nvim -c 'set ft=mail'
-- This is used by mutt
vim.api.nvim_create_autocmd("FileType", {
	pattern = "mail",
	command = [[setlocal spell spelllang=en_gb]]
--	callback = function()
--		vim.cmd [[setlocal spell spelllang=en_gb]];
--	end
});

vim.api.nvim_create_autocmd("FileType", {
	pattern = "meson",
	callback = function()
		vim.bo.softtabstop = 2;
		vim.bo.shiftwidth = 2;
		vim.bo.expandtab = true;
	end
});

vim.api.nvim_create_autocmd("FileType", {
	pattern = "gitcommit",
	callback = function()
		vim.cmd [[setlocal spell spelllang=en_gb]]
	end
});

vim.api.nvim_create_autocmd("FileType", {
	pattern = "rust",
	callback = function()
		vim.bo.expandtab = false;
	end
});

vim.api.nvim_create_autocmd("FileType", {
	pattern = "tex",
	callback = function()
		vim.cmd [[setlocal spell spelllang=en_gb]]
	end
});

