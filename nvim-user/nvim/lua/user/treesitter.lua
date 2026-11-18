local status_ok, configs = pcall(require, "nvim-treesitter.configs");
if not status_ok then
	return
end

configs.setup{
	ensure_installed = { "c", "cpp", "lua", "rust", "python" }, -- , "markdown" },
	highlight = {
		enable = true,
		-- disable = { "cpp" },
		disable = { "markdown" },
		additional_vim_regex_highlighting = false
	},
	indent = { enable = true, disable = { "c", "cpp" } },
};
