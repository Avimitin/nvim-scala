return {
  {
    "nvim-treesitter/nvim-treesitter",
    tag = "v0.9.1", -- keep in sync with neovim version
    event = "BufRead",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "scala", "nix", "cpp" },
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
        matchup = {
          enable = true,
        },
        textobjects = {
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["ab"] = "@block.outer",
              ["ib"] = "@block.inner",
              ["al"] = "@call.outer",
              ["il"] = "@call.inner",
              ["aP"] = "@parameter.outer",
              ["iP"] = "@parameter.inner",
              ["ao"] = "@conditional.outer",
              ["io"] = "@conditional.inner",
              ["as"] = "@statement.outer",
              ["ar"] = "@assignment.rhs",
            },
          },
        },
      })

      vim.api.nvim_command("set foldmethod=expr")
      vim.api.nvim_command("set foldexpr=nvim_treesitter#foldexpr()")
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "hiphish/rainbow-delimiters.nvim",
      {
        "RRethy/vim-illuminate",
        config = function()
          require("illuminate").configure({
            -- no more regex
            providers = { "treesitter", "lsp" },
          })
        end,
      },
    },
  },
}
