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

# <VS Code Server>
curl -fsSL https://code-server.dev/install.sh | sh # -s -- --dry-run

# <Cheat> https://github.com/cheat/cheat/releases
# /home/<user>/.config/cheat/cheatsheets/[community, personal]'
# /home/mate/.config/cheat/conf.yml
cd /usr/local/bin \
wget https://github.com/cheat/cheat/releases/download/4.0.1/cheat-linux-amd64.gz && gunzip cheat-linux-amd64.gz

# <NVM> curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

nvm install 14

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

#<Node-RED>
#sudo npm install -g --unsafe-perm node-red

# faster git server communication.
# like a LOT faster. https://opensource.googleblog.com/2018/05/introducing-git-protocol-version-2.html
#git config protocol.version 2

# also this unrelated thing
# git config user.email "xxxx@chromium.org"

./symlink-setup.sh