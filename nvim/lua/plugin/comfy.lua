
local around = {
  ["'"] = "'",
  ['"'] = '"',
  ['('] = ')',
  ['['] = ']',
  ['{'] = '}',
}

for key, value in pairs(around) do
  vim.keymap.set('i',key, key..value.."<Left>")
end


