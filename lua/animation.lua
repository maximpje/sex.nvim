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
local function condition(x, y, t)
    -- print(x .. " " .. y)
    if x*x + y*y < (t*t)/8 then
        return 1
    else
        return 0
    end
end

local function get_char(x, y, t)
    local char

    x = x*2
    y = y*4

    local d1 = condition(x, y+3, t)
    local d2 = condition(x, y+2, t)
    local d3 = condition(x, y+1, t)
    local d4 = condition(x+1, y+3, t)
    local d5 = condition(x+1, y+2, t)
    local d6 = condition(x+1, y+1, t)
    local d7 = condition(x, y, t)
    local d8 = condition(x+1, y, t)

    -- char = symbols['b' .. d1 .. d2 .. d3 .. d4 .. d5 .. d6]

    char = get_symbol(d1, d2, d3, d4, d5, d6, d7, d8)

    -- print(d1, d2, d3, d4, d5, d6, d7, d8)

    return char
end

-- generates a table
local function create_frame(width, height, t)
    local tstring = 't = ' .. t

    local frame = {tstring}

    local y = 0

    -- for every y a string is generated which is added to the frame table
    while y < height do
        local x = 0
        local str = ''

        while x < width do
            str = str .. get_char(x-(width/2), -y+(height/2), t)
            x = x+1
        end

        table.insert(frame, str)

        y = y+1
    end

    return frame
end

-- creates buffer
local function create_buffer()

    local buf = vim.api.nvim_create_buf(false, true)

    return buf

end

-- creates buffer and a window
local function create_window(buf, width, height)

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

-- recursive loop
local function animate(buf, width, height, t)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false,
        create_frame(width, height, t))

    if t < 400 then
        vim.defer_fn(function()
            animate(buf, width, height, t + 1)
        end, 16)
    end
end

-- defines command
function Animation.setup()
    local window = nil

    local width = 70
    local height = 30

    vim.api.nvim_create_user_command('SexAnimate', function ()
        local buf = create_buffer()
        window = create_window(buf, width, height)

        local t = 0
        animate(buf, width, height, t)
    end, {})

    vim.api.nvim_create_user_command('SexAnimateClose', function ()
        if window~=nil then
            vim.api.nvim_win_close(window, true)
        end
    end, {})
end

return Animation
