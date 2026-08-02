local Animation = {}

local function create_window()
    local width = 70
    local height = 30

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, true, {'balls'})

    local window = vim.api.nvim_open_win(buf, false, {
        relative='win',
        width=width,
        height=height,
        col=vim.api.nvim_win_get_width(0),
        row=0,
        border={"╭", "─" ,"╮", "│", "╯", "─", "╰", "│"},
        anchor='NE',
        style='minimal',
        title=' animation ',
    })

    return window
end

function Animation.setup()
    vim.api.nvim_create_user_command('SexAnimate', function ()
        create_window()
    end, {})
end

return Animation
