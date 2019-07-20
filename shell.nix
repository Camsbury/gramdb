let
  nixPinned = import (builtins.fetchTarball  "https://github.com/NixOS/nixpkgs/archive/fa82ebccf66.tar.gz") {};
in
  { nixpkgs ? nixPinned }:
    let
      gramDB = (import ./default.nix { inherit nixpkgs; });
      gramDBShell = with nixpkgs;
      haskell.lib.overrideCabal gramDB (oldAttrs: {
        librarySystemDepends = with pkgs; [
          cabal-install
          haskellPackages.ghcid
          sourceHighlight
        ];
      });
    in
      gramDBShell.env
