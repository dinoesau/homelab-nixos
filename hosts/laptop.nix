# laptop1: portable machine with GUI. No media services.
# Generate hardware report on target first:
#   sudo nixos-facter -o hosts/facter/laptop1.json
{ ... }:

{
  networking.hostName = "acer-laptop";

  # Wired is static, no DHCP. Same 192.168.100.3/24 as the old lease, so hitless.
  networking.useDHCP = false;
  networking.dhcpcd.extraConfig = "nohook hostname";

  systemd.network.enable = true;
  systemd.network.networks."10-enp1s0f1" = {
    matchConfig.MACAddress = "98:28:a6:26:e1:a4";
    address = [ "192.168.100.3/24" ];
    routes = [ { Gateway = "192.168.100.1"; } ];
    dns = [ "192.168.100.1" "2001:4860:4860::8888" ];
    networkConfig = {
      DHCP = "no";
      IPv6AcceptRA = true;
      IPv6PrivacyExtensions = "kernel";
    };
    dhcpV4Config.UseHostname = false;
    dhcpV6Config.UseHostname = false;
  };

  # Wireless stays DHCP as fallback, but never adopts transient hostname.
  systemd.network.networks."10-wlp2s0" = {
    matchConfig.MACAddress = "00:f4:8d:65:a7:21";
    networkConfig.DHCP = "yes";
    dhcpV4Config.UseHostname = false;
    dhcpV4Config.RouteMetric = 2048;
    dhcpV6Config.UseHostname = false;
  };

  services.xserver.xkb = {
    layout = "latam";
    variant = "";
  };

  time.timeZone = "America/Mexico_City";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "la-latin1";

  systemd.sleep.settings.Sleep = {
    AllowSuspend = "no";
    AllowHibernation = "no";
    AllowHybridSleep = "no";
    AllowSuspendThenHibernate = "no";
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchDocked = "ignore";
    HandleLidSwitchExternalPower = "ignore";
  };

  services.upower.ignoreLid = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
