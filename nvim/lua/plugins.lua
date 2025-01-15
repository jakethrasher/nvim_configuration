-- Sets up lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "rebelot/kanagawa.nvim",
    config = function()
      vim.cmd.colorscheme("kanagawa-wave")
    end,

  },
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "c", 
          "lua", 
          "vim", 
          "vimdoc", 
          "query", 
          "rust", 
          "python", 
          "javascript", 
          "typescript" 
        },

        auto_install = true,

        highlight = {
          enable = true,
        },
        textobjects = {
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              -- You can optionally set descriptions to the mappings (used in the desc parameter of
              -- nvim_buf_set_keymap) which plugins like which-key display
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
              -- You can also use captures from other query groups like `locals.scm`
              ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
            },
            -- You can choose the select mode (default is charwise 'v')
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            selection_modes = {
              ['@parameter.outer'] = 'v', -- charwise
              ['@function.outer'] = 'V', -- linewise
              ['@class.outer'] = '<c-v>', -- blockwise
            },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * selection_mode: eg 'v'
            -- and should return true or false
            include_surrounding_whitespace = true,
          },
        },
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      -- "hrsh7th/cmp-vsnip",
      -- "hrsh7th/vim-vsnip",
    },
    config = function()
    local cmp = require("cmp")
    cmp.setup({
      mapping = {
        -- Manually trigger completion with <C-Space>
        ['<C-Space>'] = require('cmp').mapping.complete(),
        -- Accept the selected completion item with Enter
        ['<CR>'] = require('cmp').mapping.confirm({ select = true }),
        -- Navigate through the popup menu
        ['<Tab>'] = require('cmp').mapping.select_next_item(),
        ['<S-Tab>'] = require('cmp').mapping.select_prev_item(),
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
      },
      -- Disable automatic popup triggering
      completion = {
        autocomplete = false, -- Prevent auto-triggering
      },
    })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
      lspconfig.clangd.setup({})
      lspconfig.rust_analyzer.setup({
        settings = {
          ['rust-analyzer'] = {},
        }
      })
      lspconfig.ts_ls.setup({})
      lspconfig.pyright.setup({
        capabilities = capabilities,
      })
    end,
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup {}
    end
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    keys = {
    { "<leader><leader>", function() require('telescope.builtin').find_files() end, desc = "Telescope find files" },
    { "<leader>fg", function() require('telescope.builtin').live_grep() end,  desc = "Telescope live grep"  },
    { "<leader>fb", function() require('telescope.builtin').buffers() end,    desc = "Telescope buffers"    },
    { "<leader>fh", function() require('telescope.builtin').help_tags() end,  desc = "Telescope help tags"  },
    { "<leader>fw", function() require('telescope.builtin').grep_string() end,  desc = "Telescope help tags"  },
    },
  }
})

