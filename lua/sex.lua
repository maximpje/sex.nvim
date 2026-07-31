local M = {}

function M.sex()
    local buf = vim.api.nvim_ceate_buf(false, true)

    local sexwindow = vim.api.nvim_open_win(buf, false, {relative='0', width=60, height=80})
end

function M.setup()
    vim.api.nvim_create_user_command('SexOpen', M.sex(), {})
end

return M
