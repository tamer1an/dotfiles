# copy paste this file in bit by bit.
# don't run it.
  echo "do not run this script in one go. hit ctrl-c NOW"
  read -n 1

##############################################################################################################
###  backup old machine's key items

mkdir -p ~/migration/home/
mkdir -p ~/migration/Library/"Application Support"/
mkdir -p ~/migration/Library/Preferences/
mkdir -p ~/migration/Library/Application Support/
mkdir -p ~/migration/rootLibrary/Preferences/SystemConfiguration/

cd ~/migration

# what is worth reinstalling?
npm list -g --depth=0    > npm-g-list.txt
yarn global list --depth=0 > yarn-g-list.txt

# backup some dotfiles likely not under source control
cp -Rp \
    ~/.bash_history \
    ~/.extra ~/.extra.fish \
    ~/.gitconfig.local \
    ~/.gnupg \
    ~/.nano \
    ~/.nanorc \
    ~/.netrc \
    ~/.ssh \
    ~/.z   \
        ~/migration/home

cp -Rp ~/Documents ~/migration

cp -Rp /Library/Preferences/SystemConfiguration/com.apple.airport.preferences.plist ~/migration/rootLibrary/Preferences/SystemConfiguration/ # wifi

cp -Rp ~/Library/Preferences/net.limechat.LimeChat.plist ~/migration/Library/Preferences/
cp -Rp ~/Library/Preferences/com.tinyspeck.slackmacgap.plist ~/migration/Library/Preferences/

cp -Rp ~/Library/Services ~/migration/Library/ # automator stuff
cp -Rp ~/Library/Fonts ~/migration/Library/ # all those fonts you've installed

# editor settings & plugins
cp -Rp ~/Library/Application\ Support/Sublime\ Text\ * ~/migration/Library/"Application Support"
cp -Rp ~/Library/Application\ Support/Code\ -\ Insider* ~/migration/Library/"Application Support"

##############################################################################################################
### install of common things
###

# autocompletion for git branch names https://git-scm.com/book/en/v1/Git-Basics-Tips-and-Tricks
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash

# Type `git open` to open the GitHub page or website for a repository.
npm install -g git-open

# fancy listing of recent branches
npm install -g git-recent

# nice git diffs
npm install -g diff-so-fancy

# trash as the safe `rm` alternative
#npm install --global trash-cli


# faster git server communication.
# like a LOT faster. https://opensource.googleblog.com/2018/05/introducing-git-protocol-version-2.html
#git config protocol.version 2

# also this unrelated thing
# git config user.email "xxxx@chromium.org"

./symlink-setup.sh