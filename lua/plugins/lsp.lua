return {
  -- Interact with LSP server
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    config = function()
      local icons = {
        ERROR = "",
        WARN = "",
        HINT = "",
        INFO = "",
      }
      -- Setup diagnostic icons and signs
      vim.diagnostic.config({
        virtual_text = {
          prefix = "",
          spacing = 6,
          format = function(diagnostic)
            return string.format(
              "%s  %s",
              icons[vim.diagnostic.severity[diagnostic.severity]],
              diagnostic.message
            )
          end,
        },
        signs = true,
        underline = true,
        -- update diagnostic in insert mode will be annoying when the output is too verbose
        update_in_insert = false,
      })

      local types = {
        "Error",
        "Warn",
        "Hint",
        "Info",
      }

      for _, diag_type in ipairs(types) do
        local hl = "DiagnosticSign" .. diag_type
        vim.fn.sign_define(hl, {
          text = "",
          texthl = hl,
          numhl = hl,
          linehl = hl,
        })
      end

      local config = require("lang.config")
      config.settings = {}
      config.on_attach = require("plugins.lspkeymap")

      local lspconfig = require("lspconfig")
      lspconfig["clangd"].setup(config)
      lspconfig["nil_ls"].setup(config)
    end,
  },

  -- UI for builtin LSP function
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    cmd = "LspSaga",
    config = function()
      local saga = require("lspsaga")

      -- use custom config
      saga.setup({
        -- when cursor in saga window you config these to move
        move_in_saga = { prev = "k", next = "j" },
        diagnostic_header = { " ", " ", " ", " " },
        scroll_preview = {
          scroll_down = "<C-d>",
          scroll_up = "<C-u>",
        },
        finder = {
          default = "def+ref+imp",
          silent = true,
        },
        -- same as nvim-lightbulb but async
        lightbulb = {
          sign = false,
          enable_in_insert = false,
          virtual_text = true,
        },
        symbol_in_winbar = {
          enable = true,
          separator = "  ",
          show_file = true,
        },
        ui = {
          code_action = "ﯦ",
          diagnostic = "",
          preview = "",
        },
      })

      vim.api.nvim_set_hl(0, "SagaLightBulb", { fg = "#E8C266" })
    end,
  },

  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({})
    end,
    keys = {
      "gcc",
      "gbc",
      { mode = "x", "gc" },
      { mode = "x", "gb" },
    },
  },

  {
    "scalameta/nvim-metals",
    ft = "scala",
    config = function()
      local scala_config = require("metals").bare_config()
      scala_config.settings = {
        showImplicitArguments = true,
        excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
      }

      local exepath = vim.fn.exepath("metals")
      if not exepath or exepath == "" then
        return
      end
      if vim.env["NIX_STORE"] then
        scala_config.settings.metalsBinaryPath = exepath
      end

      scala_config.capabilities = require("plugins.lspconfig").capabilities
      scala_config.on_attach = function(client, bufnr)
        -- require("metals").setup_dap()
        require("plugins.lspkeymap")(client, bufnr)
      end

      -- Autocmd that will actually be in charging of starting the whole thing
      local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        -- NOTE: You may or may not want java included here. You will need it if you
        -- want basic Java support but it may also conflict if you are using
        -- something like nvim-jdtls which also works on a java filetype autocmd.
        pattern = { "scala", "sbt", "java" },
        callback = function()
          require("metals").initialize_or_attach(scala_config)
        end,
        group = nvim_metals_group,
      })
    end,
  },
}
