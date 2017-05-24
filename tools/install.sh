#! /bin/bash

# echo " "
# echo "+++++++++++++++++++++++++++++++++++++++"
# echo "++++++++++ Starting installer.... +++++"
# echo "+++++++++++++++++++++++++++++++++++++++"
# echo " "
# Check if Git is installed, if not we
# cannot proceed.
hash git >/dev/null 2>&1 || {
    echo "Error: git is not installed"
    echo "Please install it and run this setup again."
exit 1
}

# echo " "
# echo "======================================="
# echo "========= OS dependenciesh ============"
# echo "======================================="
# echo " "
if [ "$(uname)" == "linux-gnu" ]; then
    echo -e "\n\nRunning on Linux"
    source apt.sh
fi

if [ "$(uname)" == "Darwin" ]; then
    echo -e "\n\nRunning on OSX"
    source brew.sh
fi

# echo " "
# echo "======================================="
# echo "========= oh-my-zsh   ================="
# echo "======================================="
# echo " "
DIR="$HOME/.oh-my-zsh"

if [ -d $DIR ]
then
    # echo "$DIR directory exists!"
    echo "oh-my-zsh was already installed...skipping"
else
    #  echo "$DIR directory created"
    echo "oh-my-zsh framework has been installed"
    # Get oh-my-zsh framework
    git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
fi

# echo " "
# echo "======================================="
# echo "========= Syntax Highlight zsh  ======="
# echo "======================================="
# echo " "
DIR="$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"

if [ -d $DIR ]
then
    # echo "$DIR directory exists!"
    echo "ZSH syntax highlighting was already installed...skipping"
else
    #  echo "$DIR directory created"
    echo "ZSH syntax highlighting has been installed"
    # Get Syntax highlighting
    git clone https://github.com/zsh-users/zsh-syntax-highlighting $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi

# echo " "
# echo "======================================="
# echo "========= ZSHRC ======================="
# echo "======================================="
# echo " "
FILE="$HOME/.zshrc"

if [ -f $FILE ]; then
    #  echo "File $FILE exists."
    echo "zshrc file was already installed...skipping"
else
    #  echo "$FILE File created"
    echo "zshrc file has been installed"
    # Symlink the .zshrc file that makes sure the config works
    ln -s $HOME/dotfiles/zsh/.zshrc $HOME
fi

# echo " "
# echo "======================================="
# echo "========= ZSH Theme ==================="
# echo "======================================="
# echo " "
FILE="$HOME/.oh-my-zsh/custom/adjusted.zsh-theme"

if [ -f $FILE ]; then
    #  echo "File $FILE exists."
    echo "Adjusted zsh theme was already installed...skipping"
else
    #  echo "$FILE File created"
    echo "Adjusted zsh theme has been installed"
    # Symlink the .custom theme.
    ln -s $HOME/dotfiles/zsh/theme/adjusted.zsh-theme $HOME/.oh-my-zsh/custom/
fi

# echo " "
# echo "======================================="
# echo "========= ZSH iterm Switch +==========="
# echo "======================================="
# echo " "
FILE="$HOME/.oh-my-zsh/custom/iTerm-ssh.zsh"

if [ -f $FILE ]; then
    #  echo "File $FILE exists."
    echo "iTerm ssh Switch was already installed...skipping"
else
    #  echo "$FILE File created"
    echo "iTerm ssh Switch has been installed"
    # Symlink the iTerm switcher for hosts
    ln -s $HOME/dotfiles/configscripts/iTerm-ssh.zsh $HOME/.oh-my-zsh/custom/
fi

# echo " "
# echo "======================================="
# echo "========= oh-my-vim ==================="
# echo "======================================="
# echo " "
DIR="$HOME/.oh-my-vim"

if [ -d $DIR ]
then
    echo ".oh-my-vim framework was already retrieved...skipping"
else
    echo ".oh-my-vim framework has been retrieved"
    # Get oh-my-vim framework
    git clone https://github.com/Mvzundert/oh-my-vim.git $HOME/.oh-my-vim
fi

# echo " "
# echo "======================================="
# echo "========= VIM config =================="
# echo "======================================="
# echo " "
DIR="$HOME/.vim"

if [ -L $DIR ]
then
    # echo "$DIR directory exists!"
    echo ".oh-my-vim framework has been installed...skipping"
else
    #  echo "$DIR directory created"
    echo ".oh-my-vim framework has been installed"
    # Symlink .oh-my-vim framework to .vim folder.
    ln -s $HOME/.oh-my-vim/ $HOME/.vim
fi

# echo " "
# echo "======================================="
# echo "========= VIMRC ======================="
# echo "======================================="
# echo " "
FILE="$HOME/.vimrc"

if [ -f $FILE ]; then
    #  echo "File $FILE exists."
    echo "Vimrc was already installed....skipping"
else
    #  echo "$FILE File created"
    echo "Vimrc has been installed."
    # Symlink the .vimrc file that makes sure the config works
    ln -s $HOME/.oh-my-vim/.vimrc $HOME
fi

# echo " "
# echo "======================================="
# echo "========= Vim Vundle =================="
# echo "======================================="
# echo " "
DIR="$HOME/.vim/bundle/Vundle.vim"

# Check if the Vundle dir is emtpy (it should be)
if [ "$(ls -A $DIR)" ]; then
    # We install all plugins that are specified in
    # .oh-my-vim/config/plugins.vim just to make sure.
    # echo "$DIR directory not empty"
    echo "All Vundle plugins have been installed...skipping"
    # Make sure we install all plugins
    vim +PluginInstall +qall
else
    # If the dir is empty (as it should be)
    # Get Vundle.
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    # We install all plugins that are specified in
    # .oh-my-vim/config/plugins.vim
    vim +PluginInstall +qall
fi

# echo " "
# echo "======================================="
# echo "========= TMUX  TPM ==================="
# echo "======================================="
# echo " "
DIR="$HOME/.tmux/plugins/tpm"

# Check if the tmux dir is emtpy (it should be)
if [ "$(ls -A $DIR)" ]; then
    # if we have TPM already we skip it.
    echo "TPM has been installed...skipping"
else
    # if we don't have TPM we install it.
    echo "TPM has been installed"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# echo " "
# echo "======================================="
# echo "========= TMUX Conf ==================="
# echo "======================================="
# echo " "
FILE="$HOME/.tmux.conf"

if [ -f $FILE ]; then
    #  echo "File $FILE exists."
    echo "Tmux.conf was already installed....skipping"
else
    #  echo "$FILE File created"
    echo "Tmux.conf has been installed."
    # Symlink the .tmux.conf file that makes sure the config works
    ln -s $HOME/dotfiles/tmux/.tmux.conf $HOME
fi

# echo " "
# echo "+++++++++++++++++++++++++++++++++++++++"
# echo "++++++++++ Finished +++++++++++++++++++"
# echo "+++++++++++++++++++++++++++++++++++++++"
# echo " "

echo '________          __    _____.__.__                 '
echo '\______ \   _____/  |__/ ____\__|  |   ____   ______'
echo ' |    |  \ /  _ \   __\   __\|  |  | _/ __ \ /  ___/'
echo ' |    `   (  <_> )  |  |  |  |  |  |_\  ___/ \___ \ '
echo '/_______  /\____/|__|  |__|  |__|____/\___  >____  >'
echo '        \/                                \/     \/  .... have been installed!'
echo ''
echo ''
echo 'Please look over the ~dotfiles/zsh/config, tmux.conf  and ~/.vim folders to select plugins, themes, and options.'
