
nix --extra-experimental-features 'nix-command flakes' run nixpkgs#nixos-anywhere -- --flake .#laptop --generate-hardware-config nixos-facter facter.json root@192.168.100.3


nix --extra-experimental-features 'nix-command flakes' run nixpkgs#nixos-rebuild -- --fast --flake .#laptop --target-host root@192.168.100.3 switch


nix --extra-experimental-features 'nix-command flakes' run nixpkgs#nixos-rebuild -- --no-reexec --flake .#laptop --target-host root@192.168.100.3 --build-host root@192.168.100.3 switch
