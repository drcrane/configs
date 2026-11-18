local fn = vim.fn

-- Automatically install Lazy.nvim
local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Install your plugins here
require("lazy").setup({
  -- My plugins here
  { "nvim-lua/popup.nvim", lazy = false }, -- An implementation of the Popup API from vim in Neovim
  { "nvim-lua/plenary.nvim", lazy = false }, -- Useful lua functions used by lots of plugins

  -- Colorschemes
  -- "lunarvim/colorschemes", -- A bunch of colorschemes you can try out
  -- "lunarvim/darkplus.nvim",
  { "folke/tokyonight.nvim", lazy = false },
  -- "hoprr/calvera-dark.nvim"
  { "rebelot/kanagawa.nvim", lazy = false },
  { "nvim-treesitter/nvim-treesitter" },

  { 'vladdoster/remember.nvim', lazy = false }, -- configured in remember.lua

  -- Autocompletions
  { 'hrsh7th/nvim-cmp', lazy = false },
  { 'hrsh7th/cmp-nvim-lsp', lazy = false },
  { 'hrsh7th/cmp-buffer', lazy = false },
  { 'saadparwaiz1/cmp_luasnip', lazy = false },
  { 'L3MON4D3/LuaSnip', lazy = false },

  -- LSP!
  { "neovim/nvim-lspconfig", lazy = false },
  { "brunnre8/lsp_signature.nvim", lazy = false },
  -- { "ray-x/lsp_signature.nvim", lazy = false },
});
