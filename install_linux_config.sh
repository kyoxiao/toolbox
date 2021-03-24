set +x
SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"


files_to_link=".vimrc"
for config_file in $files_to_link
do
    if [ -e ~/$config_file ]
    then
        echo rm ~/$config_file
        rm -rf ~/$config_file
    fi
	echo ln -s $SCRIPT_DIR/config/$config_file ~/$config_file
	ln -s $SCRIPT_DIR/config/$config_file ~/$config_file
	echo ''
done

#ln -s $SCRIPT_DIR/tools ~/toolbox

mkdir -p ~/.vim/toinstall
mkdir -p ~/.vim/plugin
mkdir -p ~/.vim/doc

###############################################
# Esstential tools
###############################################
yes | sudo apt install git
yes | sudo apt install vim
yes | sudo apt install build-essential
yes | sudo apt install cmake
yes | sudo apt install ctags
yes | sudo apt install python3-dev
yes | sudo apt install libssl-dev
yes | sudo apt install aptitude
yes | sudo apt install enca
yes | sudo apt install htop
yes | sudo apt install zlib1g-dev

###############################################
# set git editor
###############################################
git config --global core.editor "vim"

###############################################
# vim bundles - use Vundle to manage vim plugins
###############################################
if ! [ -e ~/.vim/bundle/Vundle.vim ]
then
    echo "git clone vundle"
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# ctrlp - CTRL+P to search and open files in current directory
if ! [ -e ~/.vim/bundle/ctrlp.vim ]
then
    echo "git clone ctrlp"
    git clone https://github.com/ctrlpvim/ctrlp.vim.git ~/.vim/bundle/ctrlp.vim
fi

# nerdtree - CTRL+N to show file strcucture
if ! [ -e ~/.vim/bundle/nerdtree ]
then
    echo "git clone nerdtree"
    git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
fi

# ycm - auto completion
# https://github.com/Valloric/YouCompleteMe#c-family-semantic-completion
if ! [ -e ~/.vim/bundle/YouCompleteMe ]
then
    echo "git clone YCM"
    git clone https://github.com/Valloric/YouCompleteMe.git ~/.vim/bundle/YouCompleteMe
    cd ~/.vim/bundle/YouCompleteMe
    git submodule update --init --recursive
    python3 install.py --clang-completer
    rm ~/.ycm_extra_conf.py
    ln -s $SCRIPT_DIR/config/.ycm_extra_conf.py ~/.ycm_extra_conf.py
fi

###############################################
# vim plugins
###############################################
# taglist - CTRL+L to list functions
if ! [ -e ~/.vim/toinstall/taglist.vim ]
then
    echo "install taglist"
    git clone https://github.com/vim-scripts/taglist.vim.git ~/.vim/toinstall/taglist.vim
    cp ~/.vim/toinstall/taglist.vim/plugin/* ~/.vim/plugin/ -r
    cp ~/.vim/toinstall/taglist.vim/doc/* ~/.vim/doc/ -r
fi

# a.vim - :A
if ! [ -e ~/.vim/toinstall/a.vim ]
then
    echo "install a.vim"
    git clone https://github.com/vim-scripts/a.vim.git ~/.vim/toinstall/a.vim
    cp ~/.vim/toinstall/a.vim/plugin/* ~/.vim/plugin/ -r
fi
