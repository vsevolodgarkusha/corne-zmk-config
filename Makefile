# Versions pinned so upstream changes don't silently break rendering. Bump when you want updates.
KEYMAP_DRAWER_VERSION := 0.23.0
NIXPKGS_REV           := 3d8f0f3f72a6cd4d93d0ad13203f2ea1cb7e1456# nixos/nixpkgs nixpkgs-unstable, 2026-05-23

KEYMAP_DRAWER := uvx --from keymap-drawer==$(KEYMAP_DRAWER_VERSION) keymap

.PHONY: draw

draw:
	$(KEYMAP_DRAWER) -c keymap-drawer/config.yaml parse -z config/cygnus.keymap \
	  | keymap-drawer/strip-outer-cols.py \
	  | $(KEYMAP_DRAWER) -c keymap-drawer/config.yaml draw - \
	  > keymap-drawer/corne.svg
	nix shell 'github:NixOS/nixpkgs/$(NIXPKGS_REV)#librsvg' -c rsvg-convert -o keymap-drawer/corne.png keymap-drawer/corne.svg
