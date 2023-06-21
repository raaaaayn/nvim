local run_formatter = function(text)
	text = text:gsub("`", "")
	local split = vim.split(text, "\n")
	local text_copy = vim.list_slice(split, 1, #split)
	-- for idx, line in ipairs(vim.list_slice(split, 2, #split - 1)) do print(vim.list_slice(split, 2, #split - 1)) end
	local result = table.concat(text_copy, "\n")

	-- Finds sql-format-via-python somewhere in your nvim config path
	local bin = vim.api.nvim_get_runtime_file("bin/sql-format-via-python.py", false)[1]

	local j = require("plenary.job"):new {
		command = "python",
		args = { bin },
		writer = { result },
	}
	return j:sync()
end

local embedded_sql = vim.treesitter.query.parse(
	"javascript",
	[[
(call_expression
	function: (identifier) @function (#eq? @function "sql")
	(template_string) @sql_string
	(#offset! @sql_string 1 0 -1 0)
)
  ]]
)

local get_root = function(bufnr)
	local parser = vim.treesitter.get_parser(bufnr, "javascript", {})
	local tree = parser:parse()[1]
	return tree:root()
end

local format_dat_sql = function(bufnr)
	-- print("Running")
	bufnr = bufnr or vim.api.nvim_get_current_buf()

	if vim.bo[bufnr].filetype ~= "javascript" then
		vim.notify "can only be used in javascript"
		return
	end

	local root = get_root(bufnr)

	local changes = {}
	for id, node in embedded_sql:iter_captures(root, bufnr, 0, -1) do
		local name = embedded_sql.captures[id]
		if name == "sql_string" then
			-- { start row, start col, end row, end col }
			local range = { node:range() }
			local indentation = string.rep(" ", range[2])

			-- Run the formatter, based on the node text
			local formatted = run_formatter(vim.treesitter.get_node_text(node, bufnr))

			-- Add some indentation (can be anything you like!)
			for idx, line in ipairs(formatted) do
				formatted[idx] = indentation .. line
			end

			-- vim.api.nvim_buf_set_text(bufnr, range[1], range[2] + 1, range[1], -3, {})
			-- range = { node:range() }

			-- Keep track of changes
			--    But insert them in reverse order of the file,
			--    so that when we make modifications, we don't have
			--    any out of date line numbers
			table.insert(changes, 1, {
				start = range[1],
				start_col = range[2],
				final = range[3],
				final_col = range[4],
				formatted = formatted,
			})
		end
	end

	for _, change in ipairs(changes) do
		print("start", change.start)
		print("startcol", change.start_col)
		print("final", change.final)
		print("finalcol", change.final_col)
		-- vim.api.nvim_buf_set_text(bufnr, change.start+1, change.start_col+1, change.final, change.final_col-1, change.formatted)
		-- vim.api.nvim_buf_set_lines(bufnr, change.start+1, change.final, false, change.formatted)
	end
end

vim.api.nvim_create_user_command("SqlMagic", function()
	format_dat_sql()
end, {})

-- local group = vim.api.nvim_create_augroup("rust-sql-magic", { clear = true })
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   group = group,
--   pattern = "*.rs",
--   callback = function()
--     format_dat_sql()
--   end,
-- })
