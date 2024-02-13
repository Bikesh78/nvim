local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
-- keymap("", "<Space>", "<Nop>", opts) --<Nop> is a key sequence that does nothing
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts) --<CR> stands for carriage return (Enter key)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts) -- toggle nvim-tree file explorer

-- Navigate buffers
keymap("n", "<leader>bn", ":bnext<CR>", opts)
keymap("n", "<leader>bb", ":bprevious<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>ft", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fh", ":Telescope help_tags<CR>", opts)   -- Search Help
keymap("n", "<leader>fw", ":Telescope grep_string<CR>", opts) -- Search current word
-- keymap("n", "<leader>fd", ":Telescope diagnostics<CR>", opts)
keymap("n", "<leader>fd", ":lua require('telescope.builtin').diagnostics({bufnr=0})<CR>", opts)
keymap("n", "<leader>fk", ":Telescope keymaps<CR>", opts)

-- Comments
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", opts)
keymap("x", "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', opts)


-- ToggleTerm
-- toggle terminal with count 1
keymap("n", "<A-1>", "<CMD>1ToggleTerm direction=horizontal<CR>", opts)
keymap("i", "<A-1>", "<CMD>1ToggleTerm direction=horizontal<CR>", opts)
keymap("t", "<A-1>", "<CMD>1ToggleTerm direction=horizontal<CR>", opts)
-- toggle terminal with count 2
keymap("n", "<A-2>", "<CMD>2ToggleTerm direction=vertical<CR>", opts)
keymap("i", "<A-2>", "<CMD>2ToggleTerm direction=vertical<CR>", opts)
keymap("t", "<A-2>", "<CMD>2ToggleTerm direction=vertical<CR>", opts)
-- toggle terminal with count 3
keymap("n", "<A-3>", "<CMD>3ToggleTerm direction=float<CR>", opts)
keymap("i", "<A-3>", "<CMD>3ToggleTerm direction=float<CR>", opts)
keymap("t", "<A-3>", "<CMD>3ToggleTerm direction=float<CR>", opts)

-- disable search highlight
keymap('n', '<leader>h', ':nohlsearch<CR>', opts)

-- Rest nvim
keymap('n', '<leader>rq', '<Plug>RestNvim', opts)
keymap('n', '<leader>rp', '<Plug>RestNvimPreview', opts)

-- Change current directory to directory containing current file
keymap('n', '<leader>cd', ':cd %:p:h<CR>', opts)

-- harpoon
keymap('n', '<leader>hm', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', opts) -- view all project marks
keymap('n', '<leader>ha', ':lua require("harpoon.mark").add_file()<CR>', opts)        -- mark file
keymap('n', '<leader>hn', ':lua require("harpoon.ui").nav_next()<CR>', opts)          --navigate to next mark
keymap('n', '<leader>hp', ':lua require("harpoon.ui").nav_prev()<CR>', opts)          --navigate to previous mark
