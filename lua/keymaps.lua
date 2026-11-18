local keymap = vim.keymap.set

-- 全选
keymap('n', '<C-a>', 'ggVG', { desc = 'Select All', })
keymap('i', '<C-a>', '<Esc>ggVG', { desc = 'Select All', })

-- 复制
keymap('n', '<C-c>', '"+yy', { desc = 'Copy Line', })
keymap('v', '<C-c>', '"+y', { desc = 'Copy Selection', })
keymap('i', '<C-c>', '<Esc>"+yy', { desc = 'Copy Line', })

-- 剪切
keymap('n', '<C-x>', '"+dd', { desc = 'Cut Line', })
keymap('v', '<C-x>', '"+d', { desc = 'Cut Selection', })
keymap('i', '<C-x>', '<Esc>"+dd', { desc = 'Cut Line', })

-- 粘贴
keymap('n', '<C-v>', '"+p', { desc = 'Paste', })
keymap('i', '<C-v>', '<C-r>+', { desc = 'Paste', })
keymap('c', '<C-v>', '<C-r>+', { desc = 'Paste', })

-- 撤销
keymap('n', '<C-z>', 'u', { desc = 'Undo', })
keymap('i', '<C-z>', '<C-o>u', { desc = 'Undo', })

-- 重做
keymap('n', '<C-y>', '<C-r>', { desc = 'Redo', })
keymap('i', '<C-y>', '<C-o><C-r>', { desc = 'Redo', })

-- 快速移动到行首和行尾
keymap('n', '<End>', '$')
keymap('n', '<Home>', '^')
keymap('v', '<End>', '$')
keymap('v', '<Home>', '^')
keymap('i', '<End>', '<C-o>$')
keymap('i', '<Home>', '<C-o>^')

-- 切换标签页
keymap({ 'n', 'i', 'v', }, '<C-Tab>', '<Esc><Cmd>bnext<CR>')
keymap({ 'n', 'i', 'v', }, '<C-S-Tab>', '<Esc><Cmd>bprevious<CR>')

-- 关闭标签页
keymap({ 'n', 'i', 'v', }, '<C-w>', '<Esc><Cmd>bdelete<CR>')

-- 减少缩进
keymap('v', '<S-Tab>', '<gv')
keymap('i', '<S-Tab>', '<C-d>')
