vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
-- vim.opt.cursorline = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.incsearch = true
vim.opt.hlsearch = true

vim.opt.scrolloff = 8
vim.opt.colorcolumn = "100"

vim.opt.updatetime = 300

print("Defaults Loaded")


vim.diagnostic.config({
  virtual_text = true,      -- show inline text
  signs = true,             -- show gutter signs
  underline = true,         -- underline errors
  update_in_insert = false, -- don't update while typing
  severity_sort = true,     -- sort by error severity

  float = {
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = function (diagnostic)
      local icons = {
        Error = " ",
        Warn = " ",
        Info = " ",
        Hint = " "
      }
      return icons[diagnostic.severity.name]
    end
  }
})

-- Show diagnostic on hover
vim.api.nvim_create_autocmd('CursorHold', {
  callback = function ()
    vim.diagnostic.open_float(nil, {
      focusable = false,
      close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
      source = 'always',
      prefix = ' ',
      scope = 'cursor',
    })
  end
})

