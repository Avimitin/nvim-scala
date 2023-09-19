return {

  -- Deep dark purple colorscheme
  {
    "rebelot/kanagawa.nvim",
    config = function()
      require("kanagawa").setup({
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = { bold = true },
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = { bold = true },
        variablebuiltinStyle = { italic = true },
        globalStatus = true,
        overrides = function(colors)
          local default = colors.palette
          return {
            RainbowDelimiterRed = { fg = default.springViolet2 },
            RainbowDelimiterYellow = { fg = default.dragonBlue },
            RainbowDelimiterBlue = { fg = default.surimiOrange },
            RainbowDelimiterGreen = { fg = default.springGreen },
            RainbowDelimiterCyan = { fg = default.waveAqua2 },
            RainbowDelimiterOrange = { fg = default.springViolet1 },
            RainbowDelimiterViolet = { fg = default.springViolet2 },
          }
        end,
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "none",
              },
            },
          },
        },
        background = {
          dark = "wave",
          light = "lotus",
        },
      })

      vim.cmd("colorscheme kanagawa")
    end,
  },

  --- List of nerd-font icons
  {
    "kyazdani42/nvim-web-devicons",
    lazy = true,
    config = function()
      require("nvim-web-devicons").setup({})
    end,
  },

  -- Status line
  {
    "glepnir/galaxyline.nvim",
    event = "UIEnter",
    config = function()
      -- Split configuration
      require("plugins.statusline")
    end,
  },

  -- tab line
  {
    "akinsho/nvim-bufferline.lua",
    event = "BufRead",
    config = function()
      require("bufferline").setup({
        options = {
          offsets = { { filetype = "neo-tree", text = " NeoTree" } },
          buffer_close_icon = "",
          modified_icon = "",
          close_icon = "",
          left_trunc_marker = "",
          right_trunc_marker = "",
          max_name_length = 14,
          max_prefix_length = 13,
          tab_size = 20,
          diagnostic = false,
          show_tab_indicators = true,
          enforce_regular_tabs = false,
          view = "multiwindow",
          show_buffer_close_icons = true,
          separator_style = "slant",
          always_show_bufferline = true,
        },
      })

      local cmd = require("lib.keymap").cmd
      require("lib.keymap").map("n", {
        { "<Tab>", cmd("BufferLineCycleNext"), desc = "Goto next buffer" },
        { "<S-Tab>", cmd("BufferLineCyclePrev"), desc = "Goto previous buffer" },
        { "<Leader>p", cmd("BufferLinePick"), desc = "Pick a buffer" },
        -- This might have effect on user tmux/terminal settings
        -- { "<M-S-right>", cmd("BufferLineMoveNext"), desc = "Move buffer to right" },
        -- { "<M-S-left>", cmd("BufferLineMovePrev"), desc = "Move buffer to left" },
      })
    end,
  },

  -- Indent guide line
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    config = function()
      require("indent_blankline").setup({
        indentLine_enabled = 1,
        char = "▏",
        filetype_exclude = {
          "help",
          "terminal",
          "dashboard",
          "packer",
          "lspinfo",
          "TelescopePrompt",
          "TelescopeResults",
          "startify",
          "dashboard",
          "dotooagenda",
          "log",
          "fugitive",
          "gitcommit",
          "packer",
          "vimwiki",
          "markdown",
          "txt",
          "vista",
          "help",
          "todoist",
          "NvimTree",
          "peekaboo",
          "git",
          "TelescopePrompt",
          "undotree",
          "flutterToolsOutline",
          "lsp-installer",
          "hydra_hint",
          "noice",
          "",
        },
        buftype_exclude = { "terminal" },
        show_trailing_blankline_indent = false,
        show_first_indent_level = false,
      })
    end,
  },

  -- Notification UI
  {
    "rcarriga/nvim-notify",
    event = "UIEnter",
    config = function()
      vim.notify = require("notify")
    end,
  },

  -- Scrollbar UI
  {
    "petertriho/nvim-scrollbar",
    lazy = true,
    event = "BufReadPost",
    config = function()
      require("scrollbar").setup({
        marks = {
          Error = { text = { "" } },
          Warn = { text = { "" } },
          Hint = { text = { "" } },
          Info = { text = { "" } },
          GitAdd = { text = "▕" },
          GitChange = { text = "▕" },
        },
        excluded_buftypes = {
          "terminal",
        },
        excluded_filetypes = {
          "prompt",
          "TelescopePrompt",
          "noice",
          "Git",
          "cmp_menu",
          "cmp_docs",
        },
        handlers = {
          cursor = false,
        },
      })
    end,
  },
  -- prettify the input and select ui
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },

  -- Neovim Library wrapper
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },

  -- UI Library
  {
    "MunifTanjim/nui.nvim",
    lazy = true,
  },
}
