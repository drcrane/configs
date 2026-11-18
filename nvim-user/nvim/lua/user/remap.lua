vim.g.mapleader = " "
vim.keymap.set("n", "<leader>n", vim.cmd.bnext)
vim.keymap.set("n", "<leader>N", vim.cmd.bprev)
vim.keymap.set("n", "<leader>e", ':Eit<CR>')
vim.keymap.set("n", "<leader>td", ":Td<CR>")

-- allow <leader>p to delete the currently highlighted portion and not save it to the paste buffer!
vim.keymap.set("x", "<leader>p", "\"_dP")
vim.keymap.set("x", "<leader>d", "\"_d")

-- throw the deleted text into the black hole register
-- vim.api.nvim_set_keymap('n', 'd', '"_d', { noremap = true });

-- this should be the same as
-- tnoremap <Esc> <C-\><C-n>
-- tnoremap <A-[> <Esc>
-- So, to send Esc to the process in the terminal window press Alt-[
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true });
vim.api.nvim_set_keymap('t', '<A-[>', '<Esc>', { noremap = true });

-- Reconfigure <PageUp> and <C-B> to go all the way to the top of the file when
-- pressed repeatedly

local function custom_page_up_conditional()
  local win = vim.api.nvim_get_current_win()
  local cursor = vim.api.nvim_win_get_cursor(win)
  local topline = vim.fn.line('w0')  -- first visible line in window
  local height = vim.api.nvim_win_get_height(win)
  local scrolloff = vim.o.scrolloff

  -- If the top of the file is visible, do custom scroll
  if topline == 1 then
    local new_line = math.max(1, cursor[1] - height + 1)

    vim.o.scrolloff = 0
    vim.api.nvim_win_set_cursor(win, { new_line, cursor[2] })
    vim.cmd('normal! zt')
    vim.o.scrolloff = scrolloff
  else
    -- Otherwise, fall back to default PageUp behavior
    local keys = vim.api.nvim_replace_termcodes('<C-B>', true, false, true)
    vim.api.nvim_feedkeys(keys, 'n', false)
  end
end

local function custom_page_up_conditional_insert_mode()
	-- local keys = vim.api.nvim_replace_termcodes('<C-o><C-b>', true, false, true)
	-- vim.api.nvim_feedkeys(keys, 'i', false)
	vim.cmd("normal! zt")
end

-- Apply to both <PageUp> and <C-B>
vim.keymap.set({ 'n', 'x' }, '<PageUp>', custom_page_up_conditional, { desc = 'PageUp (conditional scrolloff override)', noremap = true, silent = true })
vim.keymap.set({ 'n', 'x' }, '<C-B>', custom_page_up_conditional, { desc = 'Ctrl-B (conditional scrolloff override)', noremap = true, silent = true })
-- Can't seem to get this to work correctly. Might need to switch to normal mode then back into insert mode (cursor will probably move also)
-- vim.keymap.set('i', '<PageUp>', custom_page_up_conditional_insert_mode, { desc = 'PageUp (conditional scrolloff override)', noremap = true, silent = true })
-- vim.keymap.set('i', '<PageUp>', '<C-o><C-b>')

vim.keymap.set("n", "<leader>tw", [[:%s/\s\+$//e<CR>]], { desc = "Trim trailing whitespace" })
vim.keymap.set("x", "<leader>tw", [[:s/\s\+$//e<CR>]], { desc = "Trim trailing whitespace" })

-- local function trim_trailing_whitespace()
--     local mode = vim.fn.mode()
--
--     if mode:match("[vV\22]") then
--         vim.cmd([['<,'>s/\s\+$//e]])
--     else
--         vim.cmd([[%s/\s\+$//e]])
--     end
-- end
--
-- vim.keymap.set({ "n", "x" }, "<leader>tw", trim_trailing_whitespace)

