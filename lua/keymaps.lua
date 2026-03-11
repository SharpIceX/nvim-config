local keymap = vim.keymap

-- 系统剪贴板
keymap.set({ 'n', 'v' }, '<C-c>', '"+y', { desc = "复制" })
keymap.set('v', '<C-x>', '"+x', { desc = "剪切" })
keymap.set({ 'n', 'v' }, '<C-v>', '"+p', { desc = "粘贴" })
keymap.set('i', '<C-v>', '<C-r>+', { desc = "插入模式粘贴" })

-- 保存
keymap.set({ 'n', 'i', 'v' }, '<C-s>', '<cmd>w<cr><Esc>', { desc = "保存文件" })

-- 防止删除内容覆盖剪贴板
keymap.set('n', 'x', '"_x')
keymap.set('n', '<Del>', '"_x')
keymap.set('n', '<leader>d', '"_d', { desc = "删除但不复制" })

-- 缩进
keymap.set('v', '<Tab>', '>gv', { desc = "向右缩进" })
keymap.set('v', '<S-Tab>', '<gv', { desc = "向左缩进" })

-- 上下移动行
keymap.set('n', '<A-j>', ':m .+1<cr>==', { desc = "向下移动行" })
keymap.set('n', '<A-k>', ':m .-2<cr>==', { desc = "向上移动行" })
keymap.set('v', '<A-j>', ":m '>+1<cr>gv=gv", { desc = "向下移动选中行" })
keymap.set('v', '<A-k>', ":m '<-2<cr>gv=gv", { desc = "向上移动选中行" })

-- 全选
keymap.set({ 'n', 'v', 'i' }, '<C-a>', '<Esc>ggVG', { desc = "全选" })
