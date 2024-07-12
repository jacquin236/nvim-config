return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "jbyuki/one-small-step-for-vimkind",
        config = function()
          local dap = require "dap"
          dap.adapters.nlua = function(callback, config)
            local adapter = {
              type = "server",
              host = config.host,
              port = config.port,
            }
            callback(adapter)
          end

          dap.configurations.lua = {
            {
              type = "nlua",
              request = "attach",
              name = "Attach to running Neovim instance",
              host = function()
                local value = vim.fn.input "Host [127.0.0.1]: "
                if value ~= "" then
                  return value
                end
                return "127.0.0.1"
              end,
              port = function()
                local val = tonumber(vim.fn.input "Port: ")
                assert(val, "Please provide a port number.")
                return val
              end,
            },
          }
        end,
      },
    },
  },
}
