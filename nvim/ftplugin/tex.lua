vim.g.maplocalleader = " "

local opts = {silent = true, noremap = true}
local keymap = vim.api.nvim_set_keymap

--print( "I got here in tex.lua")
--vim.g.vimtex_view_method = "zathura"

keymap("n", "<localleader>v", "<Plug>(vimtex-view)", opts)

--vim.cmd [[ let g:vimtex_quickfix_filters = [
        --\ 'Underfull \\hbox', 
        --\ 'Overfull \\hbox', 
        --\ 'Latex Warning: .\+ float specifier changed to', 
        --\ 'Latex hooks Warning', 
        --\ 'Package siunitx Warning: Detected the "physics" package:',
        --\ 'Package hyperref Warning: Token not allowed in a PDF string',
      --\] ]]
      --


