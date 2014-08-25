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

Then install janus:

``` bash
  curl -Lo- https://bit.ly/janus-bootstrap | bash
```

(Same as oh-my-zsh, you can find manual install instructions in the [README](https://github.com/carlhuda/janus))

---


After that, you'll have a bunch of system tools and applications installed. The only thing left to do is to symlink the configuration files into place so that further updates to them will be reflected in this repository:

``` bash
ln -sf ~/.dotfiles/.bundle ~/.bundle &&\
ln -sf ~/.dotfiles/.gemrc ~/.gemrc &&\
ln -sf ~/.dotfiles/.gitconfig ~/.gitconfig &&\
ln -sf ~/.dotfiles/.gitignore_global ~/.gitignore_global &&\
ln -sf ~/.dotfiles/.irbrc ~/.irbrc &&\
ln -sf ~/.dotfiles/.zshrc ~/.zshrc
ln -sf "~/.dotfiles/Sublime Text 3 Preferences/" "~/Library/Application Support/Sublime Text 3/Packages/User"
```

This will set up preferences for Bundler, Rubygems, IRB, Git, and ZSH.