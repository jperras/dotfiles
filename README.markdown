## Vim dotfiles

These are the vim runtime files that I use on a daily basis. Feel free to clone, modify, change, add, murder or remove portions of it at will.

I used to be a heavy advocate and user of [Pathogen](https://github.com/tpope/vim-pathogen) by the most excellent Tim Pope, but I have recently
switched to [Vundle](https://github.com/gmarik/vundle), because I got tired of futzing around with git submodules every time I wanted to update
or remove a bundle, but I still wanted a way of controlling my entire Vim runtime from some centralized source. Vundle seems to hit all the right
sweet spots.

## Usage

**NOTE**: If you have existing files in `$HOME/.vim` or `$HOME/.vimrc`, make sure you take appropriate backups before performing any of the following steps.

 - First install Vundle, as per their [instructions](https://github.com/gmarik/vundle):

```sh
$ git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
```

 - Next, get my vim-dotfiles & symlink the `.vimrc` to your `$HOME/.vimrc`:

```sh
$ git clone git@github.com:jperras/vim-dotfiles.git ~/.vim && ln -s ~/.vim/.vimrc ~/.vimrc
```

 - Finally, we need to launch Vim and then invoke the appropriate Vundle commands to install all of the bundles using the `:BundleInstall` command. When this is completed
   you'll need to build the C extension for the [Command-T plugin](https://github.com/wincent/Command-T) plugin, which is a simple matter of cd'ing in to the command-t bundle
   folder and invoking `rake make`. I'm not quite sure if this process could somehow be automated with Vundle; if not, then that would be a fun addition to make to the project.

And that's it! Be sure to source your newly installed configuration (`:source $MYVIMRC` from inside Vim, or just restart a new editor session), and you should be good to go.

The included `.vimrc` contains some very minimal configurations that should be sane defaults for most developers, including a colorscheme that is pulled from one of the installed
bundles. Feel free to modify at will, of course. See the comments in the `.vimrc` file for more details, and check out the individual bundles that are pulled in on github until
I decide to annotate & comment on what each of them do.

## Screenshot

And here's a gratuitous screenshot: ![screenshot of vim colorscheme & some configs in action](http://f.cl.ly/items/1L2e0L3M2Y1D371J0o19/Image%202011.08.31%206:27:25%20PM.png "Screenshot")
