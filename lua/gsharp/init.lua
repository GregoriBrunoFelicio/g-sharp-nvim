local M = {}

-- User configuration. Either point at the built language server DLL via
-- `server_path` (launched with `dotnet`), or supply a full `server_cmd`.
M.config = {
  server_cmd = nil, -- e.g. { "dotnet", "/path/to/GSharp.LanguageServer.dll" }
  server_path = nil, -- e.g. "/path/to/GSharp.LanguageServer.dll"
}

function M.setup(opts)
  M.config = vim.tbl_extend("force", M.config, opts or {})
end

function M.run()
  require("gsharp.run").run()
end

return M
