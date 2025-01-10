# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.composer/vendor/bin" ] ; then
	export PATH="$HOME/.composer/vendor/bin:$PATH"
fi

# Added for flatpak
if [ -d "/var/lib/flatpak/exports/share" ] ; then
    export PATH="/var/lib/flatpak/exports/share:$PATH"
    export XDG_DATA_DIRS="/var/lib/flatpak/exports/share:$XDG_DATA_DIRS"
fi
if [ -d "/home/sebastian/.local/share/flatpak/exports/share" ] ; then
    export PATH="/home/sebastian/.local/share/flatpak/exports/share:$PATH"
    export XDG_DATA_DIRS="/home/sebastian/.local/share/flatpak/exports/share:$XDG_DATA_DIRS"
fi

# Added by Toolbox App
if [ -d "$HOME/.composer/vendor/bin" ] ; then
    export PATH="$HOME/.local/share/JetBrains/Toolbox/scripts:$PATH"
fi
