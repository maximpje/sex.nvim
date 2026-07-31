local M = {}

function girl(goon_dir)
    local goonfile = goon_dir .. '1.txt'
    local i = 0
    local lua_goon_table = {}

    for line in io.lines(goonfile) do
        table.insert(lua_goon_table, line)
        i = i+1
    end

    return lua_goon_table
end

function M.setup(goon_dir, width, height)

    vim.api.nvim_create_user_command('SexOpen', function()
        local buf = vim.api.nvim_create_buf(false, true)

        vim.api.nvim_buf_set_lines(buf, 0, -1, true, girl(goon_dir))

        local sexwindow = vim.api.nvim_open_win(buf, false, {
            relative='win',
            width=width,
            height=height,
            col=vim.api.nvim_win_get_width(0),
            row=0,
            border={"╔", "═" ,"╗", "║", "╝", "═", "╚", "║"},
            anchor='NE',
            style='minimal',
        })
    end, {})
end

return M
