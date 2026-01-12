{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    php
    php82Packages.composer
    apacheHttpd
  ];

  services.httpd = {
    enable = true;
    adminAddr = "admin@localhost";
    virtualHosts."localhost" = {
      documentRoot = "/var/www/html";
      locations."/".proxyPass = "http://localhost:80/";
    };
    enablePHP = true;
    phpPackage = pkgs.php82;
  };

  services.mysql = {
    enable = true;
    package = pkgs.mysql80;
  };
}
