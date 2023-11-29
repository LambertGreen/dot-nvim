require("lgreen.core")
require("lgreen.lazy")

-- Code: time command
function _G.time_command(cmd)
  local start_time = vim.loop.hrtime()
  vim.cmd(cmd)
  local elapsed_time = vim.loop.hrtime() - start_time
  print("Command " .. cmd .. " took " .. elapsed_time / 1e9 .. " seconds")
end
