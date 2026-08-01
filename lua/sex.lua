local M = {}

local function foid(goon_dir, goon_amount)
    local lua_goon_table = {}

    for line in io.lines(goon_dir .. math.random(1, goon_amount) .. '.txt') do
        table.insert(lua_goon_table, line)
    end

    return lua_goon_table
end

local function create_window(goon_dir, goon_amount, width, height)
    local buf = vim.api.nvim_create_buf(false, true)

    vim.api.nvim_buf_set_lines(buf, 0, -1, true, foid(goon_dir, goon_amount))

    local sexwindow = vim.api.nvim_open_win(buf, false, {
        relative='win',
        width=width,
        height=height,
        col=vim.api.nvim_win_get_width(0),
        row=0,
        border={"╭", "─" ,"╮", "│", "╯", "─", "╰", "│"},
        anchor='NE',
        style='minimal',
        title=' SEX ',
    })

    return sexwindow
end

function M.setup(goon_dir, goon_amount, width, height)

    local sexwindow = nil

    vim.api.nvim_create_user_command('SexOpen', function ()
        if sexwindow == nil then
            sexwindow = create_window(goon_dir, goon_amount, width, height)
        end
    end, {})

    vim.api.nvim_create_user_command('SexClose', function ()
        if sexwindow ~= nil then
            vim.api.nvim_win_close(sexwindow, true)
            sexwindow = nil
        end
    end, {})
end

return M
