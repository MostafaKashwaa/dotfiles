return {
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function()
      require("telescope").setup {
        defaults = {
          layout_strategy = 'vertical',
          layout_config = {
            vertical = { width = 0.9, height = 0.95 }
          },
          border = true,
          borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
        },
        extensions = {
          ['ui-select'] = {
            require("telescope.themes").get_cursor {
              layout_config = {
                width = 80,
                height = 15
              }
            }
          }
        },
        pickers = {
          hover = {
            theme = 'cursor',
            preview = {
              hide_on_startup = false
            }
          }
        }
      }

      require("telescope").load_extension('ui-select')
    end
  }

}

