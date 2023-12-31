
function ColorSetup(style)
  require('onedark').setup {
    style = style or 'dark',
    transparent = true,
    highlights = {
       ["@parameter"] = {fmt = 'italic,bold'},
       ["@todo.text"] = {fg = "green"},
    }
  }
  -- comment

  require'onedark'.load()
end

ColorSetup()

-- doesnt work
-- require("monokai-pro").setup({
--   transparent_background = true,
--   filter = "pro",
-- })

