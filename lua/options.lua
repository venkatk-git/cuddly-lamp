vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.termguicolors = true

vim.o.scrolloff = 10
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Disable arrow keys
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Split navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Yank higlighting
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Haskell higlighter options (haskell-vim)
vim.g.haskell_enable_quantification = 1
vim.g.haskell_enable_recursivedo = 1
vim.g.haskell_enable_arrowsyntax = 1
vim.g.haskell_enable_pattern_synonyms = 1
vim.g.haskell_enable_typeroles = 1
vim.g.haskell_enable_static_pointers = 1
vim.g.haskell_indent_if = 3
vim.g.haskell_indent_case = 2
vim.g.haskell_indent_let = 4
vim.g.haskell_indent_where = 6

-- Ctrl + L → delete character to the right
vim.keymap.set("i", "<C-l>", "<Del>", { desc = "Delete char to the right" })

-- "<leader>o"
-- Insert an empty line BELOW the cursor, keep cursor in same place
vim.keymap.set("n", "<leader>o", "o<Esc>k", {
  desc = "Insert line below (keep cursor)"
})

-- "s"
-- Cut into next line
vim.keymap.set("n", "<CR>", "i<CR><Esc>", {
  desc = "Split line at cursor"
})

-- ===============================
-- Option (⌥) based navigation
-- ===============================
-- <M-*> = Meta key (Option on macOS)

-- ⌥H → Move to the start of the line
-- ^  = first non-blank character
-- Works in:
--   Normal mode : jump cursor
--   Insert mode : jump without leaving insert
--   Visual mode : extend selection to line start
vim.keymap.set({ "n", "i", "v" }, "<M-h>", "^")

-- ⌥L → Move to the end of the line
-- $ = end of line
vim.keymap.set({ "n", "i", "v" }, "<M-l>", "$")

-- ⌥J → Move down by *visual line*
-- gj = move down considering wrapped lines
-- Useful when lines wrap on screen
vim.keymap.set({ "n", "i", "v" }, "<M-j>", "gj")

-- ⌥K → Move up by *visual line*
-- gk = move up considering wrapped lines
vim.keymap.set({ "n", "i", "v" }, "<M-k>", "gk")

-- =========================================================
-- Line / Selection movement (VS Code–style)
-- =========================================================

-- NORMAL MODE
-- Ctrl + J → Move the current line DOWN by one line
-- :m .+1    → move the current line (.) to one line below
-- <CR>      → execute the command
-- ==        → re-indent the moved line to match context
vim.keymap.set(
  "n",
  "<C-j>",
  ":m .+1<CR>==",
  { desc = "Move current line down" }
)

-- Ctrl + K → Move the current line UP by one line
-- :m .-2    → move the current line (.) to two lines above
--             (one extra because the line is removed first)
-- ==        → re-indent after moving
vim.keymap.set(
  "n",
  "<C-k>",
  ":m .-2<CR>==",
  { desc = "Move current line up" }
)

-- =========================================================
-- VISUAL MODE (multi-line selection)
-- =========================================================

-- Ctrl + J → Move selected lines DOWN
-- '>        → mark for end of visual selection
-- :m '>+1   → move the selection to one line below
-- gv        → reselect the previously selected text
-- =gv       → re-indent selection and keep it selected
vim.keymap.set(
  "v",
  "<C-j>",
  ":m '>+1<CR>gv=gv",
  { desc = "Move selected lines down" }
)

-- Ctrl + K → Move selected lines UP
-- '<        → mark for start of visual selection
-- :m '<-2   → move selection up correctly
-- gv=gv     → keep selection + fix indentation
vim.keymap.set(
  "v",
  "<C-k>",
  ":m '<-2<CR>gv=gv",
  { desc = "Move selected lines up" }
)

-- =========================================================
-- Line / Selection duplication
-- (Option + Shift = Meta + Shift)
-- =========================================================

-- NORMAL MODE
-- ⌥⇧J → Duplicate current line DOWN
-- yy → yank (copy) the current line
-- p  → paste below the current line
vim.keymap.set(
  "n",
  "<M-S-j>",
  "yyp",
  { desc = "Duplicate line down" }
)

-- ⌥⇧K → Duplicate current line UP
-- yy → yank (copy) the current line
-- P  → paste above the current line
vim.keymap.set(
  "n",
  "<M-S-k>",
  "yyP",
  { desc = "Duplicate line up" }
)

-- =========================================================
-- VISUAL MODE: Duplicate selection and keep it selected
-- (Safe version — no command leakage)
-- =========================================================

-- ⌥⇧J → Duplicate selected lines DOWN
vim.keymap.set(
  "v",
  "<M-S-j>",
  "<Cmd>normal! y'>p gv=gv<CR>",
  { desc = "Duplicate selection down (indent & keep selection)" }
)

-- ⌥⇧K → Duplicate selected lines UP
vim.keymap.set(
  "v",
  "<M-S-k>",
  "<Cmd>normal! y'<P gv=gv<CR>",
  { desc = "Duplicate selection up (indent & keep selection)" }
)
