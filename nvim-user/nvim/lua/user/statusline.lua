local M = {}

function M.statusline()
		local switch = function(param, case_table)
				local case = case_table[param]
				if (case) then return case() end
				local def = case_table['default']
				if (def) then return def() end
				return nil
		end
		local mode = switch(vim.api.nvim_get_mode().mode, {
				['n'] = function()
						return 'N'
				end,
				['i'] = function()
						return 'I'
				end,
				['v'] = function()
						return 'V'
				end,
				['default'] = function()
						return vim.api.nvim_get_mode().mode
				end
		})
		local parts = {
				[[%< %f ]],
				mode,
				[[ %m%=[%{&fileencoding?&fileencoding:&encoding},%{&fileformat},%{strlen(&ft)?&ft:'none'}] %p%% %l:%c ]],
		}
		return table.concat(parts, '');
end

return M
