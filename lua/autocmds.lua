local au = vim.api.nvim_create_autocmd

local smart_yank_gid = vim.api.nvim_create_augroup("SmartYank", { clear = true })
au("TextYankPost", {
  group = smart_yank_gid,
  desc = "Copy and highlight yanked text to system clipboard",
  callback = function()
    vim.highlight.on_yank({ higroup = "HighLightLineMatches", timeout = 200 })

    if not vim.fn.has("clipboard") == 1 then
      return
    end

    local copy_key_is_y = vim.v.operator == "y"
    if not copy_key_is_y then
      return
    end

    local copy = function(str)
      pcall(vim.fn.setreg, "+", str)
    end

    local present, yank_data = pcall(vim.fn.getreg, "0")
    if not present or #yank_data < 1 then
      return
    end

    copy(yank_data)
  end,
})

au({ "VimEnter" }, {
  pattern = { "*" },
  callback = function()
    local root_patterns = { ".git", ".hg", ".svn", "Cargo.toml", "go.mod", "package.json" }

    require("lib.find-root").find_root(root_patterns)
  end,
})
