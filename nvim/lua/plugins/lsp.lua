return {

  -- Mason (LSP installer manager)
  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        border = 'rounded',
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        },
      },
    },
  },

  -- Mason-LSPConfig bridge
  {
    "mason-org/mason-lspconfig.nvim",
    config = function()
      local lspconfig = require('mason-lspconfig')
      lspconfig.setup {
        automatic_enable = true,
        ensure_installed = { 'lua_ls', 'bashls', 'jsonls', 'pyright', 'clangd' }
      }
    end,
  },

  -- Native LSP Configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = { 'cmp-nvim-lsp', 'mason-lspconfig.nvim' },
    config = function()
      -- local capabilities = require('cmp_nvim-lsp').default_capabilities()
      local lspconfig = require('lspconfig')
      lspconfig.lua_ls.setup {
        -- capabilities = capabilities
      }
      lspconfig.pyright.setup {
        -- capabilities = capabilities
      }

      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
    end,
  },

  -- Autocompletion Engine
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require('cmp')
      cmp.setup ({
        snippet = {
          expand = function(args)
            if pcall(require, 'luasnip') then
              require('luasnip').lsp_expand(args.body)
            else
              vim.notify("luasnip not installed", vim.log.levels.WARN)
              vim.api.nvim_put({args.body}, "", true, true)
            end
          end
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<C-j>'] = cmp.mapping(function (fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, {'i', 's'}),
          ['<C-k>'] = cmp.mapping(function (fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, {'i', 's'}),
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
          ['<M-j>'] = cmp.mapping.scroll_docs(1),
          ['<M-k>'] = cmp.mapping.scroll_docs(-1),
        },
        sources = cmp.config.sources {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        },
        window = {
          completion = {
            border = "rounded",
            winhighlight = "Normal:Pmenu,FloatBorder:PmenuBorder,CursorLine:PmenuSel,Search:None",
            scrollbar = true,
            col_offset = -3,
            side_padding = 1,
          },
          documentation = {
            border = "rounded",
            max_width = 50,
            max_height = 30,
          },
        },
        formatting = {
          fields = {"kind", "abbr", "menu"},
          format = function(entry, vim_item)
            -- Icons from nvim-web-devicons
            local icons = {
              Text = " ",
              Method = " ",
              Function = " ",
              Constructor = " ",
              Field = " ",
              Variable = " ",
              Class = " ",
              Interface = " ",
              Module = " ",
              Property = " ",
              Unit = " ",
              Value = " ",
              Enum = " ",
              Keyword = " ",
              Snippet = " ",
              Color = " ",
              File = " ",
              Reference = " ",
              Folder = " ",
              EnumMember = " ",
              Constant = " ",
              Struct = " ",
              Event = " ",
              Operator = " ",
              TypeParameter = " ",
            }

            -- vim_item.kind = string.format("%s %s", icons[vim_item.kind] or "", vim_item.kind)
            vim_item.kind = string.format("%s", icons[vim_item.kind] or vim_item.kind)
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snip]",
              buffer = "[Buf]",
              path = "[Path]",
            })[entry.source.name]

            return vim_item
          end,
        },

        experimental = {
          ghost_text = {
            hl_group = 'Comment',
          },
        },
      })
    end
  },

  {
    "hrsh7th/cmp-nvim-lsp",
    config = true
  }
}

--
--  { "neovim/nvim-lspconfig",
--    event = "BufReadPre",
--    dependencies = {
  --      "mason.nvim",
  --      "mason-lspconfig.nvim",
  --      "hrsh7th/cmp-nvim-lsp"
  --    },
  --  }
  --}

  --{
    --    "mason-org/mason-lspconfig.nvim",
    --    dependencies = "mason.nvim",
    --    opts = {},
    --    dependencies = {
      --      { "mason-org/mason.nvim", 
      --      opts = {
        --        ui = {
          --          icons = {
            --            package_installed = "✓",
            --            package_pending = "➜",
            --            package_uninstalled = "✗"
            --          }
            --        }
            --      } 
            --    },
            --  }
