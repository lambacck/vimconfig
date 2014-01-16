# This is my .vimrc

I'm usually working with Python/Django and HTML/CSS/JavaScript, so my Vim IDE is configured for these languages.

All of the plugins are installed and updated via [Pathogen](http://github.com/tpope/vim-pathogen)!

Have fun and fork at will! :)

# Quick start

1. Clone this repo: `git clone git://github.com/lambacck/vimconfig.git ~/.vim` - **Be careful not to override your own configuration...**
2. Initialize the plugins as a sub-repositories:

        git submodule init
        git submodule update


# Syntastic Requires some external dependencies:

## Flake8

### install virtualenvwrapper

```
pip install --install-option="--user" virtualenvwrapper
echo source `python -c "import site; print site.USER_BASE"`/bin/virtualenvwrapper.sh >> ~/.bashrc
source `python -c "import site; print site.USER_BASE"`/bin/virtualenvwrapper.sh
```

### install flake8
```
mkvirtualenv flake8
pip install flake8
ln -s $WORKON_HOME/bin/flake8 ~/bin/flake8
```

## JSHint

```
sudo npm install -g jshint
```

**Enjoy!** :)
