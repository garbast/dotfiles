MAKEFLAGS += --warn-undefined-variables
SHELL := /bin/bash
.EXPORT_ALL_VARIABLES:
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.SILENT:

INSTALL_DIR := $$HOME

.PHONY: install
install:
	stow --target=$(INSTALL_DIR) git
	stow --target=$(INSTALL_DIR) neovim
	stow --target=$(INSTALL_DIR) zsh

.PHONY: clean
clean:
	stow --target=$(INSTALL_DIR) --delete zsh
	stow --target=$(INSTALL_DIR) --delete neovim
	stow --target=$(INSTALL_DIR) --delete git
