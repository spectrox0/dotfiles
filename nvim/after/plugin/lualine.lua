local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local theme = require('lualine.themes.monokai-pro')
theme.normal.c.bg = nil

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local diagnostics = {
	"diagnostics",
	sections = { "error", "warn", "info" },
	symbols = { error = " ", warn = " ", info = " " },
	colored = true,
	update_in_insert = false,
	always_visible = false,
}

local diff = {
	"diff",
	colored = true,
	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = hide_in_width
}

local mode = {
	"mode",
	colored = false,
}

local location = {
	"location",
  fmt = function(str)
    return str .. " "
  end,
	padding = 0,
}

lualine.setup({
	options = {
		icons_enabled = true,
		theme = theme,
		component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
		disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = {'mode'},
    lualine_b = {'branch', diff, diagnostics},
    lualine_c = { {'filename', file_status=true, path = 0} },
    lualine_x = {'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {location}
	},
	inactive_sections = {
		lualine_a = { mode },
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {'fugitive'},
})
