local M = {}

function M.setup(opts)
  -- reserved for future config options
end

function M.run()
  require("gsharp.run").run()
end

return M
