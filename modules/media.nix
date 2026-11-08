# Shared media services.
{ config, pkgs, ... }:

{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };

  virtualisation.docker.enable = true;
  virtualisation.oci-containers.backend = "docker";
  virtualisation.oci-containers.containers.jellyseerr = {
    image = "fallenbagel/jellyseerr:latest";
    ports = [ "5055:5055" ];
    volumes = [
      "/var/lib/jellyseerr:/app/config"
    ];
  };
}
