# Vim Motions Cheatsheet

Only what `which-key` cannot show — native vim vocabulary that lives in `:help` but is worth keeping at hand until it's in muscle memory.

When in doubt inside nvim, type the leader/prefix and wait — which-key handles plugin keys, leader maps, and `g`/`[`/`]` groups. This file covers operators, text objects, fine movement, edits, registers, marks, and windows.

## 1. Operator + motion — the grammar

The core idea: `<operator><motion-or-textobject>`. Same operator combines with any motion.

| Operator | Meaning |
|---|---|
| `d` | delete (cut into default register) |
| `c` | change (delete + enter insert) |
| `y` | yank (copy) |
| `v` | visual select |
| `gu` / `gU` | lowercase / uppercase |
| `>` / `<` | indent right / left |
| `=` | re-indent |

Examples (read as operator + motion):

- `dw` — delete to next word
- `d$` — delete to end of line
- `cit` — change inside HTML tag
- `yi(` — yank inside parens
- `vap` — visual select around paragraph
- `gUiw` — uppercase the inner word
- `>ip` — indent inner paragraph

`.` repeats the last change. Use it constantly.

## 2. Text objects

Form: `i<thing>` (inner — content only) or `a<thing>` (around — content + delimiters).

| Object | Meaning |
|---|---|
| `iw` / `aw` | word / WORD (with surrounding whitespace) |
| `i"` / `a"` | inside / around double-quoted string |
| `i'` / `a'` | inside / around single-quoted string |
| `i(` / `a(` | inside / around parens (also `ib`) |
| `i{` / `a{` | inside / around braces (also `iB`) |
| `i[` / `a[` | inside / around brackets |
| `i<` / `a<` | inside / around angle brackets |
| `ip` / `ap` | paragraph (blank-line delimited) |
| `it` / `at` | inside / around HTML/XML tag |

Combine with operators: `ci"` change inside quotes, `da{` delete around braces, `vap` visual select around paragraph.

## 3. Fine movement (no count needed)

| Key | Meaning |
|---|---|
| `f<char>` / `F<char>` | jump forward / back to next `<char>` on the line |
| `t<char>` / `T<char>` | jump till just before `<char>` |
| `;` / `,` | repeat last `f`/`t` forward / back |
| `*` / `#` | search forward / back for word under cursor |
| `%` | jump to matching bracket |
| `''` | back to last position before a jump |
| `` `` `` | back to exact column of last jump |
| `Ctrl-o` / `Ctrl-i` | jump list back / forward |
| `gd` | go to local definition (without LSP) |
| `gf` | go to file under cursor |

## 4. Fast edits

| Key | Meaning |
|---|---|
| `.` | repeat last change |
| `&` | repeat last `:s` substitute |
| `J` | join line below with this one (one space) |
| `gJ` | join without space |
| `<<` / `>>` | indent current line left / right |
| `~` | toggle case under cursor |
| `gqip` | reformat paragraph (line-wrap) |
| `Ctrl-a` / `Ctrl-x` | increment / decrement number under cursor |

## 5. Registers (essentials)

| Action | What |
|---|---|
| `"ayy` | yank line into register `a` |
| `"ap` | paste register `a` |
| `"+y` | yank to system clipboard (already default here via `clipboard=unnamedplus`) |
| `"0p` | paste last yank (survives any `d`/`c` in between) |
| `:reg` | list all registers |

## 6. Marks (essentials)

| Action | What |
|---|---|
| `ma` | set local mark `a` (in this buffer) |
| `'a` | jump to line of mark `a` |
| `` `a `` | jump to exact column of mark `a` |
| `mA` | set global mark `A` (across files) |
| `'A` | jump to file+line of mark `A` |
| `:marks` | list all marks |

## 7. Windows, buffers, tabs

| Action | What |
|---|---|
| `Ctrl-w s` | horizontal split |
| `Ctrl-w v` | vertical split |
| `Ctrl-w h/j/k/l` | move focus left/down/up/right |
| `Ctrl-w c` | close window |
| `Ctrl-w o` | only — close all other windows |
| `Ctrl-w =` | equalize window sizes |
| `:b <name>` | jump to buffer by name (tab-completion) |
| `:b#` | jump to last buffer |
| `<leader>b` | telescope buffer picker |
| `H` / `L` | previous / next buffer |

## When to consult `:help`

Beyond this file: macros (`q`/`@`), the `g` family in full (`gJ`, `gv`, `gx`, `gU`), `:global`, complex regex, command-line ex usage. `:help motion.txt` and `:help text-objects.txt` are the canonical references.
