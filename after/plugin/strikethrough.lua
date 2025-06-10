-- lua/your_strikethrough_module.lua
-- (You can put this in an auto-loaded directory like ~/.config/nvim/lua/your_plugin_name/init.lua)

local M = {} -- A table to hold our module's functions (optional, but good practice)

--- Applies strikethrough character (U+0336) to non-control characters
--- within a specified line range.
--- @param line1 number The starting line number (1-indexed).
--- @param line2 number The ending line number (1-indexed).
--- @param cp_hex string The hexadecimal Unicode codepoint (e.g., '0336').
local function apply_strikethrough_to_range(line1, line2, cp_hex)
  -- The Unicode combining long stroke overlay character
  -- When passed to vim.cmd, \uXXXX is correctly interpreted by Vim's regex engine.
  local strikethrough_char = "\\u" .. cp_hex

  -- Construct the Vim substitution command string.
  -- \%V ensures the substitution is limited to the visual selection if active,
  -- otherwise it applies to the full specified range.
  -- [^[:cntrl:]] matches any non-control character.
  -- & in the replacement string refers to the entire matched text.
  -- /ge flags: 'g' for global (all matches on a line), 'e' for no error if pattern not found.
  local cmd_string = string.format(
    "%d,%ds/\\%%V[^[:cntrl:]]/&%s/ge",
    line1,
    line2,
    strikethrough_char
  )

  -- Execute the Vim command
  vim.cmd(cmd_string)
end

-- Define the Neovim user command
vim.api.nvim_create_user_command(
  'Strikethrough',        -- The name of the command
  function(opts)           -- The Lua function to execute when the command is called
    -- CORRECTED: Use opts.line1 and opts.line2 directly
    apply_strikethrough_to_range(opts.line1, opts.line2, '0336')
  end,
  {
    range = true,         -- Allows the command to operate on a visual selection (or a range like :10,20Strikethrough)
    nargs = 0,            -- The command itself takes no arguments
    desc = 'Apply strikethrough to visual selection or line range' -- Optional: description for :h :Strikethrough
  }
)

-- Return M if you plan to expose other functions from this module
return M
