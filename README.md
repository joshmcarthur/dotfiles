dotfiles
========

A copy of my dotfiles, including configuration, tools to help with restoration, and helpful utilities. Feel free to fork and use for your own needs.

## Use

Clone the repository, including submodules:

``` git
   git clone --recursive git://github.com/joshmcarthur/dotfiles.git 
```


Next, make sure Homebrew and brew-cask is installed:

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

Then install oh-my-zsh:

``` bash
  curl -L http://install.ohmyz.sh | sh
```

(You can find manual install instructions in the [README](https://github.com/robbyrussell/oh-my-zsh) if you'd prefer)


---


After that, you'll have a bunch of system tools and applications installed. The only thing left to do is to symlink the configuration files into place so that further updates to them will be reflected in this repository:

``` bash
ln -sf ~/.dotfiles/ruby/bundle-config ~/.bundle &&\
ln -sf ~/.dotfiles/ruby/gemrc ~/.gemrc &&\
ln -sf ~/.dotfiles/git/gitconfig ~/.gitconfig &&\
ln -sf ~/.dotfiles/git/gitignore_global ~/.gitignore_global &&\
ln -sf ~/.dotfiles/ruby/irbrc ~/.irbrc &&\
ln -sf ~/.dotfiles/zsh/zshrc ~/.zshrc &&\
ln -sf ~/.dotfiles/zsh/zshenv ~/.zshenv &&\
ln -sf ~/.dotfiles/zsh/sudojosh.zsh-theme ~/.oh-my-zsh/themes/sudojosh.zsh-theme &&\
ln -sf ~/.dotfiles/vim/gvimrc ~/.gvimrc &&\
ln -sf ~/.dotfiles/vim/.vimrc ~/.vimrc &&\
ln -sf ~/.dotfiles/vim/plugins ~/.vim/plugins
```

For you convenience, there is a script which performs the above steps for you - simply execute:

``` bash
./install.sh
```


This will set up preferences for Bundler, Rubygems, IRB, Git, VIM, and ZSH, and will install my custom ZSH theme.