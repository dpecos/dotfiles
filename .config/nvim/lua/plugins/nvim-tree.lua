local setup = function()
  local nvim_tree_config = require 'nvim-tree.config'
  local tree_cb = nvim_tree_config.nvim_tree_callback

  require 'nvim-tree'.setup {
    hijack_cursor = true,
    view = {
      width = 50,
      mappings = {
        list = {
          { key = "u",  action = "dir_up" },
          { key = "v",  cb = tree_cb("vsplit") },
          { key = "yy", action = "copy" },
        },
      },
    },
    tab = {
      sync = {
        open = true,
        close = true,
      },
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = false,
    },
    update_focused_file = {
      enable = true,
      update_cwd = false,
    },
    actions = {
      use_system_clipboard = true,
      open_file = {
        window_picker = {
          enable = false,
        },
      },
    },
  }

  local api = require("nvim-tree.api")

  vim.keymap.set('n', '<C-n>', api.tree.toggle, { desc = 'Toggle nvim-tree' })
  vim.api.nvim_set_keymap('n', '<leader>r', ':NvimTreeRefresh<CR>', { desc = 'Refresh nvim-tree' })
  vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeFindFile<CR>', { desc = 'Show file nvim-tree' })

  -- close vim if nvim-tree is the last buffer

  local function tab_win_closed(winnr)
    local api = require "nvim-tree.api"
    local tabnr = vim.api.nvim_win_get_tabpage(winnr)
    local bufnr = vim.api.nvim_win_get_buf(winnr)
    local buf_info = vim.fn.getbufinfo(bufnr)[1]
    local tab_wins = vim.tbl_filter(function(w) return w ~= winnr end, vim.api.nvim_tabpage_list_wins(tabnr))
    local tab_bufs = vim.tbl_map(vim.api.nvim_win_get_buf, tab_wins)
    if buf_info.name:match(".*NvimTree_%d*$") then -- close buffer was nvim tree
      -- Close all nvim tree on :q
      if not vim.tbl_isempty(tab_bufs) then        -- and was not the last window (not closed automatically by code below)
        api.tree.close()
      end
    else                                                    -- else closed buffer was normal buffer
      if #tab_bufs == 1 then                                -- if there is only 1 buffer left in the tab
        local last_buf_info = vim.fn.getbufinfo(tab_bufs[1])[1]
        if last_buf_info.name:match(".*NvimTree_%d*$") then -- and that buffer is nvim tree
          vim.schedule(function()
            if #vim.api.nvim_list_wins() == 1 then          -- if its the last buffer in vim
              vim.cmd "quit"                                -- then close all of vim
            else                                            -- else there are more tabs open
              vim.api.nvim_win_close(tab_wins[1], true)     -- then close only the tab
            end
          end)
        end
      end
    end
  end

  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function(data)
      local IGNORED_FT = {
        "gitcommit",
      }

      -- buffer is a real file on the disk
      local real_file = vim.fn.filereadable(data.file) == 1

      -- buffer is a [No Name]
      local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

      -- &ft
      local filetype = vim.bo[data.buf].ft

      -- only files please
      if not real_file and not no_name then
        return
      end

      -- skip ignored filetypes
      if vim.tbl_contains(IGNORED_FT, filetype) then
        return
      end

      -- open the tree but don't focus it
      require("nvim-tree.api").tree.toggle({ focus = false })
    end
  })

  vim.api.nvim_create_autocmd("WinClosed", {
    callback = function()
      local winnr = tonumber(vim.fn.expand("<amatch>"))
      vim.schedule_wrap(tab_win_closed(winnr))
    end,
    nested = true
  })
end

return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
  lazy = true,
  config = function()
    setup()
  end
}