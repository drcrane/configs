local colorscheme = "tokyonight"
-- local colorscheme = "obsidian"
-- local colorscheme = "calvera"
-- local colorscheme = "kanagawa"

if colorscheme == "kanagawa" then
require('kanagawa').setup({
    compile = false,             -- enable compiling the colorscheme
    undercurl = true,            -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true},
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = false,         -- do not set background color
    dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
    terminalColors = true,       -- define vim.g.terminal_color_{0,17}
    colors = {                   -- add/modify theme and palette colors
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
    },
    overrides = function(colors) -- add/modify highlights
        return {}
    end,
    theme = "wave",              -- Load "wave" theme when 'background' option is not set
    background = {               -- map the value of 'background' option to a theme
        dark = "wave",           -- try "dragon" !
        light = "lotus"
    },
})
end

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

-- set the statusbar to the colours I like (blue by default)
local status_colorscheme = "blue"
local status_color = { fg = "#508ED8", bg = "#1C2C3F", bold = true }
local status_color_nc = { fg = "#78777f", bg = "#302F2F", bold = true }
if status_colorscheme == "blue" then
	status_color = { fg = "#508ED8", bg = "#1C2C3F", bold = true }
elseif status_colorscheme == "green" then
	status_color = { fg = "#00a531", bg = "#004214", bold = true }
	-- status_color.bg = "#004214"
elseif status_colorscheme == "red" then
	status_color = { fg = "#e84a4a", bg = "#521414", bold = true }
end
vim.api.nvim_set_hl(0, "StatusLine", status_color)
vim.api.nvim_set_hl(0, "StatusLineNC", status_color_nc)

-- and the background to transparent
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })

-- and the number bar to the same colours as obsidian
vim.api.nvim_set_hl(0, "LineNr", { fg = "#B4D3B1", bg = "#323232" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ffff00", bg = "#181818", bold = true })

