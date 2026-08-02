local Animation = {}

function Animation.setup()
    vim.api.nvim_create_user_command('SexAnimate', function ()
        print("animation")
    end, {})
end

return Animation
