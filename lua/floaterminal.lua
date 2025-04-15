float_state = {
  win =  -1,
  buf = -1,
}

local function create_floating_terminal(opts)
  local opts = opts or { buf = -1 }
  local float_buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    float_buf = opts.buf
  else
    float_buf = vim.api.nvim_create_buf(false, true)
  end
  local float_win_width = opts.width or math.floor(vim.o.columns * 0.7)
  local float_win_height = opts.height or math.floor(vim.o.lines * 0.7)
  local float_win_pos_x = math.floor( (vim.o.columns - float_win_width) / 2)
  local float_win_pos_y = math.floor( (vim.o.lines - float_win_height) / 2)
  local float_win_config = {
    relative = "editor",
    width = float_win_width,
    height = float_win_height,
    col = float_win_pos_x,
    row = float_win_pos_y,
    style = "minimal",
    border = "rounded"
  }

  local float_win = vim.api.nvim_open_win(float_buf, true,  float_win_config)

  return { win = float_win, buf = float_buf }

end

vim.keymap.set('t', '<esc><esc>', '<c-\\><c-n>')
vim.keymap.set({'n', 't'}, '<space>tt', function()
    if not vim.api.nvim_win_is_valid(float_state.win) then
      float_state = create_floating_terminal(float_state)
      if vim.bo[float_state.buf].buftype ~= "terminal" then
        vim.cmd.terminal()
      end
    else
      vim.api.nvim_win_hide(float_state.win)
    end
  end
)
