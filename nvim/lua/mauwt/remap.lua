local keymap = vim.keymap

vim.g.mapleader = " "

keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- move selected lines above or below its current position
keymap.set({ "v", "n" }, "J", ":m '>+1<CR>gv=gv")
keymap.set({ "v", "n" }, "K", ":m '>-2<CR>gv=gv")

-- Jump half a page
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

-- Searching keeping the cursor on the middle
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- Pasting without loosing the previous copy
keymap.set("x", "<leader>p", '"_dp')

-- Copying to system clipboard
keymap.set("n", "<leader>y", '"+y')
keymap.set("v", "<leader>y", '"+y')
keymap.set("n", "<leader>Y", '"+Y')

-- Deleting to void register
keymap.set("n", "<leader>d", '"_d')
keymap.set("v", "<leader>d", '"_d')

keymap.set("i", "<C-c>", "<Esc>")

-- Replace a word on the entire file
keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Floaterm Terminal
keymap.set("n", "<leader>Nt", ":FloatermNew fff <cr>")
keymap.set("n", "<leader>Kt", ":FloatermKill <cr>")

-----------------------------------
--          DAP KeyMaps           -
-----------------------------------

keymap.set("n", "<F5>", ":lua require'dap'.step_over()<CR>")
keymap.set("n", "<F6>", ":lua require'dap'.step_into()<CR>")
keymap.set("n", "<F11>", ":lua require'dap'.step_out()<CR>")
