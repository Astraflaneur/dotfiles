#!/usr/bin/env bash
#/////////////////////////////////////////////////////////////////////////////////////
#//                        Astraflaneur – Git Configuration Script                  //
#//                          By Sagar P. Barad | 2025                               //
#/////////////////////////////////////////////////////////////////////////////////////
#//                                                                                 //
#//  Script:     git_configure.sh                                                   //
#//  Created:    10 April 2025                                                      //
#//  Platform:   Linux / Unix-like                                                  //
#/////////////////////////////////////////////////////////////////////////////////////

# Prompt for user details
read -p "Enter your full name: " NAME
read -p "Enter your email address: " EMAIL
read -p "Do you want to set up SSH for GitHub? (y/n): " SETUP_SSH

# Configure global Git settings
git config --global user.name "$NAME"
git config --global user.email "$EMAIL"
git config --global core.editor "nano"
git config --global pull.rebase false
git config --global init.defaultBranch main
git config --global color.ui auto
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.cm "commit -m"
git config --global alias.last "log -1 HEAD"

echo -e "\n✅ Git configured globally for $NAME <$EMAIL>"

# Optionally set up GitHub SSH
if [[ "$SETUP_SSH" == "y" || "$SETUP_SSH" == "Y" ]]; then
    SSH_KEY="$HOME/.ssh/id_ed25519"

    if [ ! -f "$SSH_KEY" ]; then
        echo "Generating new SSH key..."
        ssh-keygen -t ed25519 -C "$EMAIL" -f "$SSH_KEY" -N ""
        eval "$(ssh-agent -s)"
        ssh-add "$SSH_KEY"
        echo -e "\n🔑 SSH key generated. Add the following to your GitHub account:\n"
        cat "$SSH_KEY.pub"
        echo -e "\n📎 GitHub SSH: https://github.com/settings/keys"
    else
        echo "SSH key already exists at $SSH_KEY"
    fi
fi

echo -e "\n🎉 Git is ready to go!"
