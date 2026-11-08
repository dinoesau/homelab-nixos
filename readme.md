
## Installing NixOS on the homelab host over SSH

```bash
nix run nixpkgs#nixos-anywhere -- \
  --flake .#laptop \
  --generate-hardware-config nixos-facter facter.json \
  root@192.168.100.3
```

## Updating OS Host over ssh

```bash
nix run nixpkgs#nixos-rebuild -- \
  --flake .#laptop \
  --target-host root@192.168.100.3 \
  --build-host root@192.168.100.3 \
  --no-reexec switch
```
