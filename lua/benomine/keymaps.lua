local keymap = vim.api.nvim_set_keymap
local options = { noremap = true }

keymap('', '<Space>', '<Nop>', options)
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
keymap('n', '<Leader>e', ':NvimTreeToggle <CR>', options)
keymap('n', '<leader>ff', ':Telescope find_files<CR>', options)
keymap('n', '<leader>ft', ':Telescope live_grep<CR>', options)
keymap('n', '<leader>fp', ':Telescope projects<CR>', options)
keymap('n', '<leader>fb', ':Telescope buffers<CR>', options)

keymap('i', '<expr> <c-j>', '("<C-n>")', options)
keymap('i', '<expr> <c-k>', '("<C-p>")', options)
keymap('i', 'jk', '<Esc>', options)
keymap('i', 'kj', '<Esc>', options)
keymap('i', '<c-u>', '<ESC>viwUi', options)
keymap('i', '<expr><TAB>', 'pumvisible() ? "<C-n>" : "<TAB>"', options)

keymap('v', '<', '<gv', options)
keymap('v', '>', '>gv', options)

-- Git
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", options)

-- Comment
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", options)
keymap("x", "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>', options)

-- DAP
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", options)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", options)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", options)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", options)
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", options)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", options)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", options)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", options)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", options)
