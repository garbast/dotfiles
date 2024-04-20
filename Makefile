all:
	stow --target=$$HOME git
	stow --target=$$HOME vim
	stow --target=$$HOME zsh

delete:
	stow --target=$$HOME --delete git
	stow --target=$$HOME --delete vim
	stow --target=$$HOME --delete zsh