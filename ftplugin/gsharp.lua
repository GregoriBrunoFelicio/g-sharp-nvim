if vim.b.did_ftplugin then return end
vim.b.did_ftplugin = true

local opt = vim.opt_local

opt.commentstring = "// %s"
opt.expandtab     = true
opt.shiftwidth    = 2
opt.softtabstop   = 2
opt.tabstop       = 2

-- Auto-closing pairs
opt.matchpairs:append("(:)")

-- <C-F5> runs the current G# file (mirrors the VS Code binding)
vim.keymap.set("n", "<C-F5>", function()
  require("gsharp").run()
end, { buffer = true, desc = "Run G# file" })
