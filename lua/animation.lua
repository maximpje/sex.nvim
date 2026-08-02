local Animation = {}

-- in unicode 8 bits represent the braille characters which are 8 dots
-- this function takes advantage of that to generate the unicode character
local function get_symbol(d1, d2, d3, d4, d5, d6, d7, d8)
    local bits =
        (d1 ~= 0 and 1 or 0) +
        (d2 ~= 0 and 2 or 0) +
        (d3 ~= 0 and 4 or 0) +
        (d4 ~= 0 and 8 or 0) +
        (d5 ~= 0 and 16 or 0) +
        (d6 ~= 0 and 32 or 0) +
        (d7 ~= 0 and 64 or 0) +
        (d8 ~= 0 and 128 or 0)

    return vim.fn.nr2char(0x2800 + bits)
end

-- this is a function to test the thingy
local function condition(x, y)
    -- print(x .. " " .. y)
    return x*x + y*y < 2025
end

local function get_char(x, y)
    local char

    x = x*2
    y = y*4

    local d1 = 0
    local d2 = 0
    local d3 = 0
    local d4 = 0
    local d5 = 0
    local d6 = 0
    local d7 = 0
    local d8 = 0


    if condition(x, y) then
        d7 = 1
    end
    if condition(x+1, y) then
        d8 = 1
    end
    if condition(x+1, y+1) then
        d6 = 1
    end
    if condition(x+1, y+2) then
        d5 = 1
    end
    if condition(x+1, y+3) then
        d4 = 1
    end
    if condition(x, y+1) then
        d3 = 1
    end
    if condition(x, y+2) then
        d2 = 1
    end
    if condition(x, y+3) then
        d1 = 1
    end

    -- char = symbols['b' .. d1 .. d2 .. d3 .. d4 .. d5 .. d6]

    char = get_symbol(d1, d2, d3, d4, d5, d6, d7, d8)

    -- print(d1, d2, d3, d4, d5, d6, d7, d8)

    return char
end

-- generates a table
local function create_frame(width, height)
    local frame = {}

    local y = 0

    while y < height do
        local x = 0
        local str = ''

        while x < width do
            str = str .. get_char(x-(width/2), -y+(height/2))
            x = x+1
        end

        table.insert(frame, str)

        y = y+1
    end

    return frame
end

-- creates buffer and a window
local function create_window()
    local width = 70
    local height = 30

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, true, create_frame(width, height))

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

-- defines command
function Animation.setup()
    vim.api.nvim_create_user_command('SexAnimate', function ()
        create_window()
    end, {})
end

return Animation
