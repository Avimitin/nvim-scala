local cmd = require("lib.keymap").cmd
local keymapper = require("lib.keymap")

keymapper.mk_keymap({
  mapleader = {
    global = ";",
  },
  normal = {
    { "j", "v:count == 0 ? 'gj' : 'j'", desc = "Go display lines downward", expr = true },
    { "k", "v:count == 0 ? 'gk' : 'k'", desc = "Go display lines upward", expr = true },
    { "<leader>w", cmd("silent w!"), desc = "Save buffer" },
    { "<ESC>", cmd("noh"), desc = "Close search highlight" },
    {
      "<leader>q",
      function()
        require("lib.bufdel").delete_buffer_expr("", false)
      end,
      desc = "Close current buffer",
    },
    { "<leader>x", cmd("x"), desc = "Save and quit" },
    { "<C-p>", [["+p]], desc = "paste" },
  },
})
