local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
  return
end

-- import luasnip plugin safely
local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
  return
end

-- import lspkind plugin safely
local lspkind_status, lspkind = pcall(require, "lspkind")
if not lspkind_status then
  return
end


local function formatForTailwindCSS(entry, vim_item)
  if vim_item.kind == 'Color' and entry.completion_item.documentation then
    local _, _, r, g, b = string.find(entry.completion_item.documentation, '^rgb%((%d+), (%d+), (%d+)')
    if r then
      local color = string.format('%02x', r) .. string.format('%02x', g) .. string.format('%02x', b)
      local group = 'Tw_' .. color
      if vim.fn.hlID(group) < 1 then
        vim.api.nvim_set_hl(0, group, { fg = '#' .. color })
      end
      vim_item.kind = "●"
      vim_item.kind_hl_group = group
      return vim_item
    end
  end
  vim_item.kind = lspkind.symbolic(vim_item.kind) and lspkind.symbolic(vim_item.kind) or vim_item.kind
  return vim_item
end
-- load vs-code like snippets from plugins (e.g. friendly-snippets)
require("luasnip/loaders/from_vscode").lazy_load()

vim.opt.completeopt = "menu,menuone,noselect"

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
    ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
    ["<C-b>"] = cmp.mapping.scroll_docs( -4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
    ["<C-e>"] = cmp.mapping.abort(), -- close completion window
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable( -1) then
        luasnip.jump( -1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  -- sources for autocompletion
  sources = cmp.config.sources({
    { name = "nvim_lsp" }, -- lsp
    { name = "luasnip" }, -- snippets
    { name = "buffer" }, -- text within current buffer
    { name = "path" }, -- file system paths
  }),
  -- configure lspkind for vs-code like icons
  formatting = {
    format = lspkind.cmp_format({
      maxwidth = 50,
      ellipsis_char = "...",
      before = function(entry, vim_item)
        vim_item = formatForTailwindCSS(entry, vim_item)
        return vim_item
      end
    }),
  },
})


vim.cmd [[
let g:UltiSnipsJumpForwardTrigger='<Tab>'
let g:UltiSnipsJumpBackwardTrigger='<S-Tab>'
]]
