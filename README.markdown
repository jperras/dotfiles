## The Dotfiles

These are the Vim runtime files that I use on a daily basis. Feel free to
clone, modify, change, add, murder or remove portions of it at will.

Note that I actually use [NeoVim](https://github.com/neovim/neovim), and have
been doing so for quite some time now without any compatibility issues.

I used to be a heavy advocate and user of
[Pathogen](https://github.com/tpope/vim-pathogen) by the most excellent Tim
Pope, then I switched to
[Vundle](https://github.com/gmarik/vundle) because I got tired of futzing
around with git submodules every time I wanted to update or remove
a bundle. About a year after using and liking Vundle, I began using neovim
in earnest, and found that it was stable enough for my day-to-day usage.
Due to some underlying work in neovim,
[vim-plug](https://github.com/junegunn/vim-plug) is able to take advantage
of some parallel execution of installs/updates of the underlying git
repositories that make up the collection of plugins, among other several
other nice features that are listed in the
[README](https://github.com/junegunn/vim-plug/blob/master/README.md).

## Usage

**NOTE**: If you have existing files in `$HOME/.vim`, `$HOME/.vimrc`,or
the neovim equivalents `$HOME/.nvim` and `$HOME/.nvimrc`, make sure you
take appropriate backups before performing any of the following steps.

 - First install Vim-Plug, as per their
   [instructions](https://github.com/junegunn/vim-plug#installation):

```sh
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

> Change the destination to `~/.nvim/autoload/plug.vim` in the above if
> you're using NeoVim, of course. This applies to all steps.

 - Next, get my vim-dotfiles & symlink the `.vimrc` to your `$HOME/.vimrc`:

```sh
$ git clone git@github.com:jperras/vim-dotfiles.git ~/.vim && ln -s ~/.vim/.vimrc ~/.vimrc
```

 - There are several extensions required to make some extensions function
   correctly. You'll need to install the following to your system:

   * [*fzf*](https://github.com/junegunn/fzf): For the best fuzzy file-finding you'll ever use.
   * *ctags*: For the tagbar functionality.
   * [*the_silver_searcher*](https://github.com/ggreer/the_silver_searcher): For a better grep.
   * [*flake8*](https://pypi.python.org/pypi/flake8): For Python syntax & PEP8 validation via Syntastic.


 - Finally, we need to launch Vim and then invoke the appropriate Vim-Plug
   commands to install all of the bundles using the `:PlugInstall`
   command.

And that's it! Be sure to source your newly installed configuration (`:source
$MYVIMRC` from inside Vim, or just restart a new editor session), and you
should be good to go.

The included `.vimrc` contains some very minimal configurations that should be
sane defaults for most developers. Feel free to modify at will, of course. See the
comments in the `.vimrc` file for more details, and check out the individual
bundles that are pulled in on github until I decide to annotate & comment on
what each of them do.

## Screenshot

And here's a gratuitous screenshot using a fullscreen iTerm window, a few split panes, and the default colorscheme: ![screenshot](https://s3.amazonaws.com/nerderati.captures/J65KS.png)
