#installing command line tools
xcode-select --install

#installing Homebrew if it's not already installed
if test ! $(which brew)
then
    echo 'installing Homebrew'
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo 'Homebrew already installed'
fi

#update Homebrew
brew update

#install Cask
brew tap caskroom/cask

#install mas (Mac App Store) 
brew install mas


touch installed

brew install wget
wget --version | Head -n 1 >> installed
brew install vim
vim --version | Head -n 1 >> installed
brew install git
git --version >> installed
brew install node
echo -n "node " >> installed && node --version >> installed
brew install htop
htop --version | Head -n 1 >> installed
brew install ruby
ruby --version >> installed
brew install python
python --version >> installed
brew install nasm
nasm --version >> installed

# Function to check if an app is already installed
function install () {
    mas list | grep -i "$1" > /dev/null
    if [ "$?" == 0 ]
    then
        echo "$1 already installed"
    else
        echo "installing $1..."
        mas search "$1" | {read app_ident app_name ; mas install $app_ident}
    fi
}

#if you have an Apple ID just Sign into the AppStore before launching the script if not just remove the following section
################### *Additional Apps* ###################
install "Slack"
install "Extractor"
install "Todist"
install "Pages"
install "Keynote"
install "Numbers"
install "Amphetamine"
install "Soulver"
#########################################################

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

brew cask install docker 
brew cask install visual-studio-code
brew cask install iterm2 brave-browser

##################### Additional Configuration ############################
# No more .DS_Store files
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Enable and disable maginfication on dock (change the value for true if you like the amginfication effect on Dock)
defaults write com.apple.dock magnification -bool false

# Lock screen immediately (security reasons)
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0
############################################################################

# Relaunch Dock and Finder  
killall Dock
killall Finder

# Cleaning Up the caches 
echo "Cleaning up"
brew cleanup
rm -f -r /Library/Caches/Homebrew/*

cat installed 