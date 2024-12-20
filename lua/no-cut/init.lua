-- lua/no-cut/init.lua

local M = {}

-- Таблица для настройки переназначений
M.options = {
	d = true, -- Включить переназначение для команды 'd'
	x = true, -- Включить переназначение для команды 'x'
	s = true, -- Включить переназначение для команды 's'
	c = true, -- Включить переназначение для команды 'c'
	dd = true, -- Включить переназначение для команды 'dd'
	D = true, -- Включить переназначение для команды 'D'
	C = true, -- Включить переназначение для команды 'C'
	S = true, -- Включить переназначение для команды 'S'
	visual_commands = {
		d = true, -- Включить переназначение для 'd' в визуальном режиме
		c = true, -- Включить переназначение для 'c' в визуальном режиме
	},
	exceptions = { "Y" }, -- Команды, которые не нужно переназначать
	paste_without_copy = true, -- Отключить копирование текста при вставке
}

-- Функция настройки плагина
function M.setup(opts)
	-- Объединяем пользовательские настройки с дефолтными
	M.options = vim.tbl_deep_extend("force", M.options, opts or {})

	-- Настраиваем команды в нормальном режиме
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

	-- Настраиваем команды в визуальном режиме, если они включены
	if M.options.visual_commands then
		for cmd, enabled in pairs(M.options.visual_commands) do
			if enabled then
				vim.keymap.set("v", cmd, '"_' .. cmd, { noremap = true, silent = true })
			end
		end
	end

	-- Настраиваем вставку без копирования
	if M.options.paste_without_copy then
		vim.keymap.set("n", "p", '"_dP', { noremap = true, silent = true })
		vim.keymap.set("v", "p", '"_dP', { noremap = true, silent = true })
	end

	print("No-Cut: Команды успешно переназначены")
end

return M
