local M = {}

-- Resolves the command used to launch the G# language server, in priority order:
--   1. an explicit `server_cmd` from setup()
--   2. a `server_path` to the built DLL, launched via `dotnet`
--   3. a `gsharp-lsp` executable on PATH (e.g. a published single-file build)
local function resolve_cmd()
  local config = require("gsharp").config

  if config.server_cmd then
    return config.server_cmd
  end

  if config.server_path then
    return { "dotnet", config.server_path }
  end

  if vim.fn.executable("gsharp-lsp") == 1 then
    return { "gsharp-lsp" }
  end

  return nil
end

function M.start()
  local cmd = resolve_cmd()

  if not cmd then
    vim.notify(
      "gsharp: language server not configured. Set `server_path` or `server_cmd` in "
        .. "require('gsharp').setup{}, or put `gsharp-lsp` on PATH.",
      vim.log.levels.WARN
    )
    return
  end

  -- Root the workspace at the current file's directory so module siblings resolve.
  local bufname = vim.api.nvim_buf_get_name(0)
  local root_dir = bufname ~= "" and vim.fs.dirname(bufname) or vim.loop.cwd()

  vim.lsp.start({
    name = "gsharp",
    cmd = cmd,
    root_dir = root_dir,
  })
end

return M
