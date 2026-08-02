local goon = require('goon')
local animation = require('animation')

local M = {}

function M.setup(args)

    local goon_dir = args.goon_path
    local goon_amount = args.goon_amount

    goon.setup(goon_dir, goon_amount)
    animation.setup()

    vim.api.nvim_create_user_command('SexVersion', function ()
        print('sex.nvim   version: 0.0    commit: animation testing 3')
    end, {})

    vim.api.nvim_create_user_command('SexUpdate', function ()
        vim.pack.update({ 'sex.nvim'}, { force=true })
    end, {})
end

return M
