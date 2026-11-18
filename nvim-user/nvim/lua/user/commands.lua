-- one should probably use:
-- vim.inspect(o) - obviously this is only when using lua in neovim
-- print(vim.inspect(o))
local function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

local function here_to_eol()
	local line = vim.fn.getline(".");
	local pos = vim.api.nvim_win_get_cursor(0)[2] + 1;
	return string.sub(line, pos);
end

vim.api.nvim_create_user_command('Eit', function()
--	local line = vim.fn.getline(".") .. "\n";
	local line = here_to_eol() .. "\n";
	local winnr = vim.fn.winnr();
	local windows = vim.fn.getwininfo();
	local count = 0;
	local winidx = 1;
	local otherwinidx = 0
	for idx, val in pairs(windows) do
		count = count + 1;
		if val.winnr == winnr then
			winidx = idx;
		else
			otherwinidx = idx;
		end
	end
--	print("idx = " .. idx);
--	print(count)
	if count ~= 2 then
--		print("Got two windows " .. winidx .. "  " .. otherwinidx);
--	else
		print("Can't work unless 2 windows");
		return;
	end
	local terminal_buffer = vim.fn.getbufvar(vim.fn.winbufnr(otherwinidx), "terminal_job_id", -1);
	if terminal_buffer == -1 then
		print("Cannot find terminal buffer id");
		return;
	end
	vim.fn.chansend(terminal_buffer, line);
	-- print(windows[1].winnr);
end,{});
