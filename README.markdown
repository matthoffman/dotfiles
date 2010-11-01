Intro
=====

This repo started with twerth's dotfiles repo (http://github.com/twerth/dotfiles). 
See his excellent blog entries about his setup, bash files, vim files and so 
on at http://blog.infinitered.com.  For example, http://blog.infinitered.com/entries/show/9
He is a far better designer, bash hacker, and vim customizer than I; I've just
modded a few things to suit. 

His original intro: 

> This repo started out with just my . files (mainly vim files), but over time 
> I've added to it, and now it represents a subset of all my command-line 
> folders.

I store all my command-line files in a folder (twerth uses "cl", I use 
"src/dotfiles"... see "Installation" below for more on that), then under that 
folder there are 3 sub-folders (cl/bin cl/etc cl/doc), to keep them organized 
away from all my other files.  I link (etc/link) the dot files to the root of 
my home folder, so I prefer to store them without the . (gitignore rather than
.gitignore), then I add the dot in the link.  So if you use one, make sure you 
put the dot back.

  * ~
  ** src
  *** dotfiles
  **** bin
  **** docs
  **** etc
  ***** vim
          
Installation 
============

There are three steps to installation: clone this repo, update submodules, 
link to where it needs to go.

Clone this repository
---------------------

`
git clone git://github.com/matthoffman/dotfiles.git  ~/src/dotfiles
`

This will create a folder called ~/src/dotfiles, with folders named "bin" and 
"etc" inside it. Of course, you might want it somewhere different.  twerth, who
originated most of these files (git://github.com/twerth/dotfiles.git), puts his
in ~/cl/dotfiles.  Put them wherever you want, but grep the scripts for 
"src/dotfiles" -- it's called out explicitly in etc/bashrc when sourcing in 
other bashrc_* files, and could be in some other places. 

Then, `cd ~/src/dotfiles` and run: 

`
git submodule update --init
`

Create symlinks
---------------

The "links" file in bin exists for this, but be very careful -- it 
is indiscriminately deletes existing files!  You may be more comfortable just
linking the files yourself.  See what the "links" script does, and manually
link those files that you care about.  For example: 

`
ln -s ~/src/dotfiles/etc/vim/vimrc ~/.vimrc
ln -s ~/src/dotfiles/etc/vim/gvimrc ~/.gvimrc
ln -s ~/src/dotfiles/etc/vim ~/.vim
`

Vim Bundles
===========

Unlike twerth's dotfiles repo, which this was forked from, I'm using 
tpope's pathogen plugin to organize vim plugins into directories.  I'm doing
this mainly because the cool kids are.  Google "pathogen vim" for more info.
The primary advantage for me (at least, hoped-for advantage, I'm still trying
it out) is that it will let me keep the plugins up-to-date easier.
We'll see. 

Adding new bundles
------------------

To add, say, Command-T (don't, it's already there, as an example): 
cd ~/src/dotfiles   
(you need to be in the root of the git repository)
git submodule add http://github.com/vim-scripts/Command-T etc/vim/bundle/command-t

Some plugins that aren't bundled
--------------------------------

There are a couple plugins that aren't installed as bundles, but instead directly
in the etc/vim/ directory. In some cases that's laziness, in others there aren
specific reasons.  Here's some that have specific reasons:

### snipmate

Snipmate is currently not a bundle, but installed directly into etc/vim.  That's
because I wanted to be able to modify snippets and have them carried between 
machines, and that was the most expedient way to do it.

### fuzzyfinder

Fuzzyfinder is currently installed in plugins because we're stuck on a 
particular old version (2.16) for compatibility with fuzzyfinder-textmate.  
See http://weblog.jamisbuck.org/2009/1/28/the-future-of-fuzzyfinder-textmate
These might be removed in the future; I'm using command-t instead anyway. 
Fuzzyfinder-textmate is installed in plugins for the same reason. And its not
maintained, so there's no reason to keep it as a submodule.


Warning
======= 

I mod these all the time, and sometimes I break stuff.  Also, my main platform
at the moment is OS X, so that's likely all this is tested in.  It will likely
work on Linux as well (twerth's originals worked on Debian-based Linux at 
least) but it probably hasn't been extensively tested there. I'd like to keep
it all linux-compatible, so if you use something and it breaks for you in 
Linux, let me know.
