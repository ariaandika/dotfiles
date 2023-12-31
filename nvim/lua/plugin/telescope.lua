local builtin = require 'telescope.builtin'
local actions = require("telescope.actions")
local m = vim.keymap.set
local desc = function(d) return { desc = d } end

pcall(require('telescope').load_extension, 'fzf')

require("telescope").setup{
  defaults = {
    mappings = {
      i = { ["<esc>"] = actions.close },
    },
  },
  pickers = {
		-- find_files = {
		-- 	find_command = { "rg", "--files", "--hidden", "--glob", "!**/{.git,node_modules}/*" },
		-- },
	},
}

m('n', '<tab>', builtin.buffers,            desc("Telescope: buffer"))
m('n', '<leader><tab>', builtin.find_files, desc("Telescope: all file"))
m('n', '<leader>td', builtin.diagnostics,    desc("Telescope: diagnostic"))
m('n', '<leader>tp', builtin.builtin,       desc("Telescope: all builtin"))
m('n', '<leader>ts', function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end,  desc("Telescope: grep string"))
