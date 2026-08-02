local Goon = {}

local prev = 0

local function gen_random(goon_amount)
    local ran = math.random(1, goon_amount)

    if prev ~= ran then
        prev = ran
    else
        ran = gen_random(goon_amount)
    end

    return ran
end

local function foid(goon_dir, goon_amount)
    local lua_goon_table = {}

    for line in io.lines(goon_dir .. gen_random(goon_amount) .. '.txt') do
        table.insert(lua_goon_table, line)
    end

    return lua_goon_table
end

local function create_window(goon_dir, goon_amount)
    local buf = vim.api.nvim_create_buf(false, true)
    local lua_goon_table = foid(goon_dir, goon_amount)

    local height = #lua_goon_table
    local width = string.len(lua_goon_table[1])/3

    vim.api.nvim_buf_set_lines(buf, 0, -1, true, lua_goon_table)

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

function Goon.setup(goon_dir, goon_amount)
    local sexwindow = nil

    vim.api.nvim_create_user_command('SexOpen', function ()
        if sexwindow == nil then
            sexwindow = create_window(goon_dir, goon_amount)
        end
        end, {})

    vim.api.nvim_create_user_command('SexClose', function ()
        if sexwindow ~= nil then
            vim.api.nvim_win_close(sexwindow, true)
            sexwindow = nil
        end
    end, {})

    vim.api.nvim_create_user_command('SexReload', function ()
        vim.api.nvim_cmd({cmd = 'SexClose'}, {})
        vim.api.nvim_cmd({cmd = 'SexOpen'}, {})
    end, {})

end

return Goon
