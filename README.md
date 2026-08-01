# sex.nvim

sex.nvim is a all in one gooner suite for the nvim experience. We vimmers love to stay inside the nvim envoirement, we browse, create files and even some manage their version control inside it, so why not do the gooning too?

This repository does NOT contain any gooning material, it does NOT have any explicit content.

# usage

With sex.vim you can open a floating gooner window with :SexOpen, this will open a random piece of ascii art from a specified folder.

# installation

with vim.pack

```lua
vim.pack.add({
    "https://github.com/maximpje/sex.nvim",
)}
```

```lua
require('sex').setup(
    '/PATH/TO/YOUR/GOON/MATERIAL', -- has to be an absolute path
    90, -- width of the sex window
    30 -- height of the sex window
)
```

# To Do

- Randomizer
- :SexClose
- Nicer looking floating window
- Better configuration
- Better README
- Support for kitty image protocol and other terminal image protocols
- Animation