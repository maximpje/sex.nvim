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
    5 -- the amount of goon pics in the goon material folder
)
```

Your goon material folder should have at least one ascii art, it should be named '1.txt', with the second one being called '2.txt' etc.

```
goon_material
├── 1.txt
└── 2.txt
```

You can add as many as you want.

# To Do

- Better configuration
- Support for kitty image protocol and other terminal image protocols
- Animation
