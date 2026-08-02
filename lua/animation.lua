local Animation = {}

local symbols = {
    b000000 = ' ',
    b000001 = '⠁',
    b000010 = '⠈',
    b000011 = '⠉',
    b000100 = '⠂',
    b000101 = '⠃',
    b000110 = '⠊',
    b000111 = '⠋',
    b001000 = '⠐',
    b001001 = '⠑',
    b001010 = '⠘',
    b001011 = '⠙',
    b001100 = '⠒',
    b001101 = '⠓',
    b001110 = '⠚',
    b001111 = '⠛',
    b010000 = '⠄',
    b010001 = '⠅',
    b010010 = '⠌',
    b010011 = '⠍',
    b010100 = '⠆',
    b010101 = '⠇',
    b010110 = '⠎',
    b010111 = '⠏',
    b011000 = '⠔',
    b011001 = '⠕',
    b011010 = '⠜',
    b011011 = '⠝',
    b011100 = '⠖',
    b011101 = '⠗',
    b011110 = '⠞',
    b011111 = '⠟',
    b100000 = '⠠',
    b100001 = '⠡',
    b100010 = '⠨',
    b100011 = '⠩',
    b100100 = '⠢',
    b100101 = '⠪',
    b100110 = '⠸',
    b100111 = '⠹',
    b101000 = '⠢',
    b101001 = '⠣',
    b101010 = '⠪',
    b101011 = '⠫',
    b101100 = '⠲',
    b101101 = '⠳',
    b101110 = '⠺',
    b101111 = '⠻',
    b110000 = '⠤',
    b110001 = '⠥',
    b110010 = '⠬',
    b110011 = '⠭',
    b110100 = '⠦',
    b110101 = '⠧',
    b110110 = '⠮',
    b110111 = '⠯',
    b111000 = '⠴',
    b111001 = '⠵',
    b111010 = '⠼',
    b111011 = '⠽',
    b111100 = '⠶',
    b111101 = '⠷',
    b111110 = '⠾',
    b111111 = '⠿',
}

local function condition(x, y)
    return x > y
end

local function get_char(x, y)
    local char

    local d1 = 0
    local d2 = 0
    local d3 = 0
    local d4 = 0
    local d5 = 0
    local d6 = 0

    if condition(x*2, y*3) then
        d6 = 1
    end
    if condition((x*2)+1, y*3) then
        d5 = 1
    end
    if condition(x*2, (y*3)+1) then
        d4 = 1
    end
    if condition((x*2)+1, (y*3)+1) then
        d3 = 1
    end
    if condition(x*2, (y*3)+2) then
        d2 = 1
    end
    if condition((x*2)+1, (y*3)+2) then
        d1 = 1
    end

    char = symbols['b' .. d1 .. d2 .. d3 .. d4 .. d5 .. d6]

    return char
end

local function create_frame(width, height)
    local frame = {}

    local x = 0
    local y = 0

    while y <= width do
        local str = ''

        while x <= height do
            str = str .. get_char(x, y)
            x = x+1
        end

        table.insert(frame, str)

        y = y + 1
    end

    print(frame)

    return frame
end

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

function Animation.setup()
    vim.api.nvim_create_user_command('SexAnimate', function ()
        create_window()
    end, {})
end

return Animation
