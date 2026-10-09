vim.opt.backup = false -- creates a backup file
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.cmdheight = 2 -- more space in the neovim command line for displaying messages
vim.opt.colorcolumn = "99999" -- fixes indentline for now
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8" -- the encoding written to a file
vim.opt.foldmethod = "manual" -- folding set to "expr" for treesitter based folding
-- vim.opt.foldmethod = "indent" -- folding set to "indent" 
vim.opt.foldexpr = "" -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
vim.opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
vim.opt.hidden = true -- required to keep multiple buffers and open multiple buffers
vim.opt.hlsearch = true -- highlight all matches on previous search pattern
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.mouse = "a" -- allow the mouse to be used in neovim
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 2 -- always show tabs
vim.opt.smartcase = true -- smart case
vim.opt.smartindent = true -- make indenting smarter again
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false -- creates a swapfile
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 500 -- time to wait for a mapped sequence to complete (in milliseconds)
-- vim.opt.title = true -- set the title of window to the value of the titlestring
-- vim.opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to
vim.opt.undodir = vim.fn.stdpath "cache" .. "/undo"
vim.opt.undofile = true -- enable persistent undo
vim.opt.updatetime = 300 -- faster completion
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2 -- insert 2 spaces for a tab
vim.opt.cursorline = true -- highlight the current line
vim.opt.number = true -- set numbered lines
vim.opt.relativenumber = true -- set relative numbered lines
vim.opt.numberwidth = 4 -- set number column width to 2 {default 4}
vim.opt.signcolumn = "yes" -- always show the sign column otherwise it would shift the text each time
vim.opt.wrap = false -- display lines as one long line
vim.opt.spell = false
vim.opt.spelllang = "en"
vim.opt.scrolloff = 8 -- is one of my fav
vim.opt.sidescrolloff = 8

-- show whitespace: tabs, trailing spaces, and indent guides
vim.opt.list = true
vim.opt.listchars = { tab = "│ ", trail = "·", nbsp = "␣" }

-- indent guides: a │ at each indent level, sized to the buffer's indent width
-- (python's ftplugin uses 4 spaces, the global default here is 2)
local function set_indent_guides()
  local width = math.max(vim.fn.shiftwidth(), 1)
  vim.opt_local.listchars:append({ leadmultispace = "│" .. string.rep(" ", width - 1) })
end
vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter" }, { callback = set_indent_guides })
vim.api.nvim_create_autocmd("OptionSet", { pattern = { "shiftwidth", "tabstop" }, callback = set_indent_guides })

-- guide color: some themes (e.g. gruvbox) make Whitespace nearly the background color,
-- so after any colorscheme loads, mix 35% of the text color into the background
local function set_whitespace_hl()
  local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
  if not (normal.fg and normal.bg) then
    return
  end
  local function channel(color, shift)
    return math.floor(color / 2 ^ shift) % 256
  end
  local mixed = 0
  for _, shift in ipairs({ 16, 8, 0 }) do
    local fg, bg = channel(normal.fg, shift), channel(normal.bg, shift)
    mixed = mixed + math.floor(bg + (fg - bg) * 0.35 + 0.5) * 2 ^ shift
  end
  vim.api.nvim_set_hl(0, "Whitespace", { fg = mixed })
end
vim.api.nvim_create_autocmd("ColorScheme", { callback = set_whitespace_hl })

-- colorscheme
-- vim.cmd [[colorscheme everforest]] -- set colorscheme to everforest
vim.cmd [[colorscheme tokyonight-day]] -- set colorscheme to everforest
-- vim.cmd [[colorscheme gruvbox]] -- set colorscheme to everforest
-- vim.opt.winblend = 0
