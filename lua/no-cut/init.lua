local M = {}

-- Default configuration options
M.options = {
	d = true, -- Remap 'd' to avoid copying to clipboard
	x = true, -- Remap 'x' to avoid copying to clipboard
	s = true, -- Remap 's' to avoid copying to clipboard
	c = true, -- Remap 'c' to avoid copying to clipboard
	dd = true, -- Remap 'dd' to avoid copying to clipboard
	D = true, -- Remap 'D' to avoid copying to clipboard
	C = true, -- Remap 'C' to avoid copying to clipboard
	visual_commands = {
		d = true, -- Remap 'd' in visual mode
		c = true, -- Remap 'c' in visual mode
	},
	exceptions = { "Y" }, -- Commands to exclude from remapping
	paste_without_copy = true, -- Prevent copying replaced text during paste
}

-- Function to configure the plugin
function M.setup(opts)
	-- Merge user options with defaults
	M.options = vim.tbl_deep_extend("force", M.options, opts or {})

	-- Remap normal mode commands
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

	-- Remap visual mode commands
	if M.options.visual_commands then
		for cmd, enabled in pairs(M.options.visual_commands) do
			if enabled then
				vim.keymap.set("x", cmd, '"_' .. cmd, { noremap = true, silent = true })
			end
		end
	end

	-- Handle paste without copying replaced text
	if M.options.paste_without_copy then
		vim.keymap.set("n", "p", '"_dP', { noremap = true, silent = true })
		vim.keymap.set("n", "P", '"_dP', { noremap = true, silent = true })
		vim.keymap.set("x", "p", '"_dP', { noremap = true, silent = true })
		vim.keymap.set("x", "P", '"_dP', { noremap = true, silent = true })
	end

	print("No-Cut.nvim: Commands remapped successfully.")
end

return M
