local set = function(a,b,c,d) return vim.keymap.set(a,b,c,{ desc = d, remap = true }) end



-- Undo Tree
set('n','<leader>u',vim.cmd.UndotreeToggle, "UndoTree: open window")

-- Git Fugitive
set('n','<leader>gs', vim.cmd.Git,          "Git: open window")



-- Comment
---@diagnostic disable-next-line: missing-fields
require'Comment'.setup({
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
})

set('v', '<C-_>', 'gc', "Comment: toggle")


function Cope()
    require("copilot").setup({})
end
