local M = {}

local term_chan = nil

local function find_term_win(bufnr)
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == bufnr then
      return win
    end
  end
  return nil
end

local function find_term_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.b[buf].gsharp_terminal then
      return buf
    end
  end
  return nil
end

function M.run()
  local filepath = vim.api.nvim_buf_get_name(0)

  if not filepath:match("%.gs$") then
    vim.notify("Not a G# file (.gs)", vim.log.levels.ERROR)
    return
  end

  -- Save current buffer
  vim.cmd("write")

  -- Check if our terminal channel is still alive
  local term_alive = term_chan and vim.fn.jobwait({ term_chan }, 0)[1] == -1
  local term_buf = term_alive and find_term_buf() or nil

  if term_buf then
    local win = find_term_win(term_buf)
    if win then
      vim.api.nvim_set_current_win(win)
    else
      vim.cmd("split")
      vim.api.nvim_win_set_buf(0, term_buf)
    end
  else
    -- Open a new terminal in a split below
    vim.cmd("split | terminal")
    term_buf = vim.api.nvim_get_current_buf()
    term_chan = vim.b[term_buf].terminal_job_id
    vim.b[term_buf].gsharp_terminal = true
  end

  if term_chan then
    vim.fn.chansend(term_chan, string.format('gs "%s"\n', filepath))
  end
end

return M
