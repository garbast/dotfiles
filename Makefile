all:
	stow --target=$$HOME git
	stow --target=$$HOME neovim
	stow --target=$$HOME zsh

clean:
	stow --target=$$HOME --delete zsh
	stow --target=$$HOME --delete neovim
	stow --target=$$HOME --delete git
