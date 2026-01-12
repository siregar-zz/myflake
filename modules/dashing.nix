{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nagios
    check_mk
    smashing
    nodejs
    yarn
  ];

  # Web server untuk dashboard
  services.caddy = {
    enable = true;
    virtualHosts."localhost:8080" = {
      extraConfig = ''
        reverse_proxy localhost:3000
      '';
    };
  };

  # Nagios monitoring service
  services.nagios = {
    enable = true;
    objectDefs = [];
  };
}
