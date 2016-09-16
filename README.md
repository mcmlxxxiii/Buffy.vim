Buffy is a text menu (one item per line) consisting of names of currently
edited files from all buffers.

Upon stepping on an item (file name) in the Buffy menu and pressing `<Enter>`
key, the buffer with the chosen file will be placed into a current window.
To delete a chosen buffer, press `x` or `d`.

Buffy may be invoked inside any window with the `:Buffy` command. That command
may be bound to a key combination. By default, `:Buffy` is bound to `<Leader>b`.

If you prefer a different key combination, make sure to disable the default
binding first:

    let g:buffy_default_key_binding = 0
    nnoremap <F8> :Buffy<CR>


## Installation

Buffy is [pathogen][1]-compatible. Just git clone it into your `~/.vim/bundle` and
restart Vim.

    git clone https://github.com/mcmlxxxiii/Buffy.vim.git ~/.vim/bundle/Buffy

[1]: https://github.com/tpope/vim-pathogen
