local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function ()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

require('telescope').setup({
	defaults = {
		layout_config = {
			vertical = { width = 0.5 }
		},
		file_ignore_patterns = { "node%_modules/.*", "vendor/.*" }
	}
})
