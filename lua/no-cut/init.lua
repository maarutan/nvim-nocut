local M = {}

-- Table for remapping options
M.options = {
	d = true, -- Enable remapping for the 'd' command
	x = true, -- Enable remapping for the 'x' command
	s = true, -- Enable remapping for the 's' command
	c = true, -- Enable remapping for the 'c' command
	dd = true, -- Enable remapping for the 'dd' command
	D = true, -- Enable remapping for the 'D' command
	C = true, -- Enable remapping for the 'C' command
	S = true, -- Enable remapping for the 'S' command
	visual_commands = {
		d = true, -- Enable remapping for 'd' in visual mode
		c = true, -- Enable remapping for 'c' in visual mode
	},
	exceptions = { "Y" }, -- Commands that should not be remapped
	paste_without_copy = true, -- Disable copying text during paste
}

-- Function to configure the plugin
function M.setup(opts)
	-- Merge user settings with defaults
	M.options = vim.tbl_deep_extend("force", M.options, opts or {})

	-- Configure commands in normal mode
	for cmd, enabled in pairs(M.options) do
		if
			enabled
			and cmd ~= "visual_commands"
			and cmd ~= "exceptions"
			and cmd ~= "paste_without_copy"
			and type(enabled) == "boolean"
		then
			if not vim.tbl_contains(M.options.exceptions, cmd) then
				vim.keymap.set("n", cmd, '"_' .. cmd, { noremap = true, silent = true })
			end
		end
	end

	-- Configure commands in all visual modes if enabled
	if M.options.visual_commands then
		for cmd, enabled in pairs(M.options.visual_commands) do
			if enabled then
				vim.keymap.set("x", cmd, '"_' .. cmd, { noremap = true, silent = true }) -- 'x' covers all visual modes
			end
		end
	end

	-- Configure paste without copying
	if M.options.paste_without_copy then
		-- Handle normal mode paste
		vim.keymap.set("n", "p", "p", { noremap = true, silent = true })
		vim.keymap.set("n", "P", "P", { noremap = true, silent = true })

		-- Handle visual mode paste for all visual modes
		vim.keymap.set("x", "p", "p", { noremap = true, silent = true })
		vim.keymap.set("x", "P", "P", { noremap = true, silent = true })
	else
		-- Preserve custom behavior for "p" to avoid copying replaced text
		vim.keymap.set("n", "p", '"_dP', { noremap = true, silent = true })
		vim.keymap.set("x", "p", '"_dP', { noremap = true, silent = true })
	end

	print("No-Cut: Commands successfully remapped")
end

return M
