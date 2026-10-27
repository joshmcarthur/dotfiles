#!/bin/sh

ln -sf $HOME/.dotfiles/ruby/bundle-config $HOME/.bundle
ln -sf $HOME/.dotfiles/ruby/gemrc $HOME/.gemrc
ln -sf $HOME/.dotfiles/git/gitconfig $HOME/.gitconfig
ln -sf $HOME/.dotfiles/git/gitignore_global $HOME/.gitignore_global
ln -sf $HOME/.dotfiles/ruby/irbrc $HOME/.irbrc
ln -sf $HOME/.dotfiles/zsh/zshrc $HOME/.zshrc
ln -sf $HOME/.dotfiles/zsh/zshenv $HOME/.zshenv
ln -sf $HOME/.dotfiles/zsh/sudojosh.zsh-theme $HOME/.oh-my-zsh/themes/sudojosh.zsh-theme
ln -sf $HOME/.dotfiles/vim/gvimrc $HOME/.gvimrc
ln -sf $HOME/.dotfiles/vim/vimrc $HOME/.vimrc
ln -sf $HOME/.dotfiles/vim/plugins $HOME/.vim/bundle

mkdir -p $HOME/.claude $HOME/.codex $HOME/.copilot $HOME/.cursor/rules
ln -sfn $HOME/.dotfiles/agents/AGENTS.md $HOME/.claude/CLAUDE.md
ln -sfn $HOME/.dotfiles/agents/AGENTS.md $HOME/.codex/AGENTS.md
ln -sfn $HOME/.dotfiles/agents/AGENTS.md $HOME/.copilot/copilot-instructions.md
ln -sfn $HOME/.dotfiles/agents/AGENTS.md $HOME/.cursor/rules/agents.mdc
