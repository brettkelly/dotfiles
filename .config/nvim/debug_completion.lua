-- Debug script for obsidian + blink.cmp completion
-- Run this with :luafile debug_completion.lua in a markdown file

local function debug_completion()
  print("=== Debugging Obsidian + Blink Completion ===")
  
  -- Check if we're in a markdown file
  print("Current filetype:", vim.bo.filetype)
  print("Current file:", vim.fn.expand('%:p'))
  
  -- Check if obsidian.nvim is loaded
  local obsidian_ok, obsidian = pcall(require, 'obsidian')
  print("obsidian.nvim loaded:", obsidian_ok)
  
  if obsidian_ok then
    local client = obsidian.get_client()
    if client then
      print("Obsidian client active:", client.current_workspace.name)
      print("Workspace path:", client.current_workspace.path)
    else
      print("No obsidian client active")
    end
  end
  
  -- Check if blink.cmp is loaded
  local blink_ok, blink = pcall(require, 'blink.cmp')
  print("blink.cmp loaded:", blink_ok)
  
  -- Check if blink.compat is loaded
  local compat_ok, compat = pcall(require, 'blink.compat')
  print("blink.compat loaded:", compat_ok)
  
  if blink_ok then
    -- Try to get available sources
    local sources = blink.get_sources()
    if sources then
      print("Available blink sources:")
      for name, source in pairs(sources) do
        print("  - " .. name)
      end
    end
  end
  
  -- Check if nvim-cmp is available (needed for compat)
  local cmp_ok, cmp = pcall(require, 'cmp')
  print("nvim-cmp available:", cmp_ok)
  
  if cmp_ok then
    print("CMP sources available:")
    local sources = cmp.get_sources()
    for _, source in ipairs(sources) do
      print("  - " .. source.name .. " (enabled: " .. tostring(not source.is_available or source:is_available()) .. ")")
    end
  end
end

debug_completion()