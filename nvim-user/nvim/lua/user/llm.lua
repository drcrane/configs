-- Global variable to store selected text
_G.visual_selection = ""

local table = table or {}  -- If table is not defined (e.g., in Lua 5.1), define it
if not table.unpack then
	table.unpack = unpack  -- Use Lua 5.1's global 'unpack'
end

-- Function to capture the current visual selection
function _G.capture_visual_selection()
	-- Save the current mode to check if it's visual
--	local mode = vim.fn.mode()
--	#if mode ~= "v" and mode ~= "V" and mode ~= "\22" then
--		#print("Not in visual mode")
--		# return
--		#end
	--vim.cmd("normal! gv")

	print(vim.inspect(vim.fn.getpos("'<")))

	-- Get the start and end position of the visual selection
	local _, start_line, start_col, _ = table.unpack(vim.fn.getpos("'<"))
	local _, end_line, end_col, _ = table.unpack(vim.fn.getpos("'>"))

	-- Adjust for 0-indexing
	start_line = start_line - 1
	end_line = end_line - 1

	-- Fetch lines from the buffer
	local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line + 1, false)

	-- Trim the first and last lines based on selection columns
	if #lines == 1 then
		lines[1] = string.sub(lines[1], start_col, end_col)
	else
		lines[1] = string.sub(lines[1], start_col)
		lines[#lines] = string.sub(lines[#lines], 1, end_col)
	end

	-- Concatenate the lines and store in the global variable
	_G.visual_selection = table.concat(lines, "\n")

	print("Visual selection captured!")
end

