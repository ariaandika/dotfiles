
require'Comment'.setup{
  toggler = {
    line = '<C-_>',
    block = 'gbc',
  },
  opleader = {
    line = 'gc',
    block = 'gb',
  },
  mappings = {
    ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
    basic = true,
    extra = false,
  },
}
-- ctrl + /
vim.keymap.set('v', '<C-_>', 'gc', { remap = true })
