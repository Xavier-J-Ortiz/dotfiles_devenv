# dotfiles

Personal development environment configuration for Ubuntu/Debian machines.

## Requirements

- Ubuntu / Debian (install script uses `apt-get`)
- `git`, `curl`, `wget`, `unzip` (typically pre-installed)
- Run as your normal user with `sudo` access

## Install

Clone the repo and run the install script from inside it:

```bash
git clone https://github.com/Xavier-J-Ortiz/dotfiles_devenv.git ~/dotfiles
cd ~/dotfiles
bash install.sh
```

The script is safe to re-run. On each run it:
- **Skips** symlinks that are already correct.
- **Backs up** any existing file that would be overwritten to
  `~/.dotfiles-backup/<timestamp>/` before replacing it.
- Prints a summary of created / skipped / backed up counts at the end.

## What's configured

| Domain | Tool(s) |
|---|---|
| Shell | Bash + [Starship](https://starship.rs) prompt |
| Terminals | Alacritty, Ghostty, WezTerm (all use Mononoki Nerd Font 11pt) |
| Multiplexer | tmux with tmux-powerkit (github-dark theme, weather/datetime/battery/cpu/mem/git) |
| Editor | Neovim (lazy.nvim, Mason-managed LSP/lint/format toolchain) |
| Fallback editor | Vim with vim-plug |
| LSPs | gopls, ruff, basedpyright, ty, bash-language-server, lua_ls, marksman |
| Linters | golangci-lint, ruff, luacheck, vale, shellcheck, codespell, markdownlint-cli2 |
| Formatters | gofumpt, goimports, stylua, shfmt, prettier |
| Prose linting | Vale (write-good ruleset + shared Neovim spell vocabulary) |
| AI | opencode.nvim |

## Spell vocabulary (Vale + Neovim)

The personal spell file (`config/nvim/spell/en.utf-8.add`) is **not tracked in
git** — vocabulary is per-machine. On a fresh install, an empty file is created
automatically so the Vale symlink is never broken.

To add a word to both Neovim spellcheck and Vale, open any file in Neovim and
press `zg` over the word.

## Platform support

Ubuntu / Debian only. The install script will exit with an error on other
systems.

## License

MIT — see [LICENSE](LICENSE).
