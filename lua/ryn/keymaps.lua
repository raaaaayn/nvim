local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

-- save, exit, exit without saving file
map("n", "<C-s>", ":w<cr>")
map("n", "<C-x>", ":x<cr>")
map("n", "<C-q>", ":q!<cr>")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set("n", "<leader>p", [["+p]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-R><C-W>\>/<C-R><C-W>/gI<Left><Left><Left>]])

-- source config
map("n", "<F4>", ":lua package.loaded.main = nil <cr>:source ~/.config/nvim/init.lua <cr>")
-- nnoremap <leader>cb <cmd>lua require("main").curr_buf() <cr>

-- NvimTree
-- map("n", "<C-n>", ":NvimTreeToggle<CR>")

map("n", "<C-n>", ":Ex<CR>")
-- Vim Rest console
vim.g.vrc_set_default_mapping = 0
map("n", ";", ":call VrcQuery()<CR>")

vim.g.vrc_curl_opts = {
	["-s"] = "",
	["-i"] = ""
}

vim.g.vrc_auto_format_response_patterns = {
	['json'] = 'python3 -m json.tool',
	['xml'] = 'xmllint --format -',
}

-- let g:vrc_curl_opts = {
--       \ '-s':'',
--       \ '-i':'',
--     \}

-- Git conflict
map("n", "gco", ":GitConflictChooseOurs<CR>")
map("n", "gct", ":GitConflictChooseTheirs<CR>")
map("n", "gcb", ":GitConflictChooseBoth<CR>")
map("n", "gn", ":GitConflictNextConflict<CR>")
map("n", "gp", ":GitConflictPrevConflict<CR>")

map("n", "<C-g>", ":G<CR>")

-- Git fugitive
map("n", "<C-g>", ":G<CR>")

-- Go to tab by number
map("n", "<leader>1", "1gt")
map("n", "<leader>2", "2gt")
map("n", "<leader>3", "3gt")
map("n", "<leader>4", "4gt")
map("n", "<leader>5", "5gt")
map("n", "<leader>6", "5gt")
map("n", "<leader>7", "7gt")
map("n", "<leader>9", "8gt")
map("n", "<leader>0", ":tablast<cr>")
map("n", "<leader>tt", ":tabnew<cr>")
map("n", "<leader>f", vim.lsp.buf.format)
