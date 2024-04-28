require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "wq", "<cmd> wq <CR>")
map("n", "qq", "<cmd> q <CR>")
map("n", "qa", "<cmd> qa! <CR>")

-- Source config
map("n", "<Leader>so", "<cmd>source %<cr>", { desc = "Source config" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map("n", "gcc", function()
  require("Comment.api").toggle.linewise.current()
end, { desc = "Comment Toggle" })

map(
  "v",
  "gcc",
  "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
  { desc = "Comment Toggle" }
)

-- LSP
map("n", "<Leader>gf", vim.lsp.buf.format, { desc = "LSP: Format files"})

-- Debugger
map("n", "<Leader>db", require("dap").toggle_breakpoint, { desc = "Debugger: Debug Breakpoint" })
map("n", "<Leader>dc", require("dap").continue, { desc = "Debugger: Debug Continue" })
map("n", "<Leader>dsv", require("dap").step_over, { desc = "Debugger: Debug Step Over" })
map("n", "<Leader>ds", require("dap").step_into, { desc = "Debugger: Debug Step Into" })
map("n", "<Leader>dso", require("dap").step_out, { desc = "Debugger: Debug Step Out" })
map("n", "<Leader>dt", require("dap").terminate, { desc = "Debugger: Debug Terminate" })
map("n", "<Leader>dpr", require("dap-python").test_method, { desc = "Debugger: Debug Python Test Method" })

-- Telescope
map("n", "<Leader>k", "<cmd>Telescope keymaps<cr>", { desc = "Telescope: Show keymaps" })
map("n", "<Leader>tdc", require("telescope").extensions.dap.commands, { desc = "DAP, Telescope: Show DAP Commands" })
map("n", "<Leader>tdb", require("telescope").extensions.dap.list_breakpoints, { desc = "DAP, Telescope: Show DAP Breakpoints" })
map("n", "<Leader>tdv", require("telescope").extensions.dap.variables, { desc = "DAP, Telescope: Show DAP Variables" })
map("n", "<Leader>tdf", require("telescope").extensions.dap.frames, { desc = "DAP, Telescope: Show DAP Frames" })
map("n", "<Leader>tdg", require("telescope").extensions.dap.configurations, { desc = "DAP, Telescope: Show DAP Configurations" })

map("n", "<Leader>ft", "<cmd>TodoTelescope<cr>", { desc = "TODO, Telescope: Show TODO comments" })
