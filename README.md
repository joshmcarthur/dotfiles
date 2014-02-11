dotfiles
========

A copy of my dotfiles, including configuration, tools to help with restoration, and helpful utilities. Feel free to fork and use for your own needs.

## Use

First of all, make sure Homebrew and brew-cask is installed:

* `ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"`
* `brew tap phinze/cask`
* `brew install brew-cask`

Then install Homebrew system tools:

```
cat homebrew_installed | xargs -n1 brew install
```

Then install Applications using Cask:

```
cat homebrew_cask_installed | xargs -n1 brew cask install
```

After that, you'll have a bunch of system tools and applications installed. The only thing left to do is to symlink the configuration files into place so that further updates to them will be reflected in this repository: 

``` bash
ln -sf .bundle ~/.bundle &&\
ln -sf .gemrc ~/.gemrc &&\
ln -sf .gitconfig ~/.gitconfig &&\
ln -sf .gitignore_global ~/.gitignore_global &&\
ln -sf .irbrc ~/.irbrc &&\
ln -sf .zshrc ~/.zshrc
```

This will set up preferences for Bundler, Rubygems, IRB, Git, and ZSH.