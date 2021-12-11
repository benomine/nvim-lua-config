local keymap = vim.api.nvim_set_keymap
local options = { noremap = true }

keymap('n', '<C-f>', ':NERDTreeFocus<CR>', options)
keymap('n', '<C-t>', ':NERDTreeToggle<CR>', options)
keymap('n', '<C-n>', ':NERDTree<CR>', options)
keymap('n', '<M-j>', ':resize -2<CR>', options)
keymap('n', '<M-k>', ':resize +2<CR>', options)
keymap('n', '<M-h>', ':vertical resize -2<CR>', options)
keymap('n', '<M-l>', ':vertical resize +2<CR>', options)
keymap('n', '<c-u>', 'viwU<Esc>', options)
keymap('n', '<TAB>', ':bnext<CR>', options)
keymap('n', '<S-Tab>', ':bprevious<CR>', options)
keymap('n', '<C-s>', ':w<CR>', options)
keymap('n', '<C-Q>', ':wq!<CR>', options)
keymap('n', '<C-c>', '<Esc>', options)
keymap('n', '<C-h>', '<C-w>h', options)
keymap('n', '<C-j>', '<C-w>j', options)
keymap('n', '<C-k>', '<C-w>k', options)
keymap('n', '<C-l>', '<C-w>l', options)
keymap('n', '<Leader>o', 'o<Esc>^Da', options)
keymap('n', '<Leader>O', 'O<Esc>^Da', options)

keymap('i', '<expr> <c-j>', '("<C-n>")', options)
keymap('i', '<expr> <c-k>', '("<C-p>")', options)
keymap('i', 'jk', '<Esc>', options)
keymap('i', 'kj', '<Esc>', options)
keymap('i', '<c-u>', '<ESC>viwUi', options)
keymap('i', '<expr><TAB>', 'pumvisible() ? "<C-n>" : "<TAB>"', options)
keymap('i', '<C-J>', 'copilot#Accept("<CR>")', {expr=true, silent=true})

keymap('v', '<', '<gv', options)
keymap('v', '>', '>gv', options)

