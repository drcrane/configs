local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Useful for debugging:
-- :lua vim.print(vim.lsp.get_clients())

-- LuaLS/lua-language-server
local lualangsvr = os.getenv("HOME") .. "/.local/lua-language-server/bin/lua-language-server"
local lualangsvr_stat = vim.loop.fs_stat(lualangsvr)
local lualangsvr_exists = lualangsvr_stat and lualangsvr_stat.type == "file"
if lualangsvr_exists and vim.fn.executable(lualangsvr) then
	vim.lsp.config("lua_ls", {
		cmd = { lualangsvr },
		filetypes = { "lua" },
	});
	vim.lsp.enable("lua_ls");
end

-- rust-analyzer
-- This seems to work provided you edit your files from a directory where
-- the server (lsp server rust-analyzer that is) can find Cargo.toml
if vim.fn.executable("rust-analyzer") then
	vim.lsp.config("rust-analyzer", {
		cmd = { "rust-analyzer" },
		capabilities = capabilities,
		filetypes = { "rust" },
--		root_dir = function(bufnr)
--			vim.fs.root(bufnr, { "Cargo.toml", ".git" });
--		end,
	});
	vim.lsp.enable("rust-analyzer");
end

-- local servers = { 'clangd' }
-- for _, lsp in ipairs(servers) do
--   nvim_lsp[lsp].setup {
--     -- on_attach = my_custom_on_attach,
--     capabilities = capabilities,
--   }
-- end

-- print(vim.lsp)
-- vim.api.nvim_create_autocmd('LspAttach', { callback = function(ev) print('callbacked!') end })

if vim.fn.executable"clangd" then
	vim.lsp.config("clangd", {
		cmd = {"clangd"},
		capabilities = capabilities,
		filetypes = { "c", "cpp" },
	});
	vim.lsp.enable("clangd");
end

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
	-- Adds the location to the jump list, go backwards with CTRL-O and forward with CTRL-I
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
	-- vim.keymap.set('n', 'gd', function(opts) print('gd callback') end, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- These are for NerdFonts
-- see https://neovim.io/doc/user/diagnostic.html for more detail (SIGNS)
vim.diagnostic.config({
	virtual_text = { prefix = "■ " },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = " ",
			[vim.diagnostic.severity.INFO] = "󰋼 ",
		},
		linehl = {
		},
		numhl = {
		}
	},
	underline = true
});

