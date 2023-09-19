return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    config = function()
      vim.g.neo_tree_remove_legacy_commands = 1

      require("neo-tree").setup({
        close_if_last_window = true,
        sources = {
          "filesystem",
          "buffers",
          "git_status",
          "document_symbols",
        },
        open_files_do_not_replace_types = {
          "terminal",
          "trouble",
          "qf",
          "diff",
          "fugitive",
          "fugitiveblame",
          "notify",
        },
        window = {
          width = 30,
          mappings = {
            ["<Tab>"] = "next_source",
            ["<S-Tab>"] = "prev_source",
          },
        },
        source_selector = {
          winbar = true,
          statusline = false,
          sources = {
            { source = "filesystem" },
            { source = "git_status" },
            { source = "document_symbols" },
          },
        },
      })
    end,
    -- End of config
    keys = {
      { "<leader>t", "<CMD>Neotree action=focus toggle=true reveal=true position=left<CR>", desc = "Open file explorer" },
      { "<leader>fl", "<CMD>Neotree source=filesystem reveal=true position=float<CR>", desc = "Open floating file explorer" },
    },
    cmd = {
      "Neotree",
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    config = function()
      require("telescope").setup()
    end,
    keys = {
      {
        "<leader>ff",
        function()
          require("telescope.builtin").find_files()
        end,
        desc = "Find file",
      },
      {
        "<leader>fd",
        function()
          require("telescope.builtin").lsp_document_symbols()
        end,
        desc = "Find symbol",
      },
      {
        "<leader>fs",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Find keyword",
      },
    },
  },

  -- auto pair () [] ""
  {
    "hrsh7th/nvim-insx",
    event = "InsertEnter",
    branch = "main",
    config = function()
      require("insx.preset.standard").setup()
    end,
  },

  -- Highlight search symbol and quick jump
  {
    "kevinhwang91/nvim-hlslens",
    keys = {
      {
        "n",
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
      },
      {
        "N",
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
      },
      { "*", [[*<Cmd>lua require('hlslens').start()<CR>]] },
      { "#", [[#<Cmd>lua require('hlslens').start()<CR>]] },
      { "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]] },
      { "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]] },
    },
    config = function()
      require("hlslens").setup()
      require("scrollbar.handlers.search").setup()
    end,
  },

  -- Key cheatsheet
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local whichkey = require("which-key")
      whichkey.setup({})

      local ngrp = {
        mode = "n",
        ["g"] = { name = "+LSP" },
        ["<leader>g"] = { name = "+Git" },
        ["<leader>f"] = { name = "+Telescope" },
      }
      whichkey.register(ngrp)
    end,
  },
}
