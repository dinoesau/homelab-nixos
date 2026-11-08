
## Installing NixOS on the homelab host over SSH

```bash
nix run nixpkgs#nixos-anywhere -- \
  --flake .#laptop \
  --generate-hardware-config nixos-facter facter.json \
  root@192.168.100.3
```


### Update password after install for `root` and `dinoesau` user

Update root password

```bash
sudo passwd -l root
```

Update dinoesau password

```bash
sudo passwd -l dinoesau
```

## Updating OS Host over ssh

```bash
nix run nixpkgs#nixos-rebuild -- \
  --flake .#laptop \
  --target-host root@192.168.100.3 \
  --build-host root@192.168.100.3 \
  --no-reexec switch
```

### Clean Reinstall (nix-mineral bypass)

The blocker is only that nixos-anywhere hardcodes /root/kexec, and your current system mounts /root as noexec (via nix-mineral). 

Temporary remount (simplest, hardening returns after reinstall anyway since disko wipes):

```bash
ssh root@192.168.100.3 'mount -o remount,exec /root'
```

Now you can run the install command as always
