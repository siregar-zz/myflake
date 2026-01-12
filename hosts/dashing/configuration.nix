{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "dashing";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Jakarta";

  i18n.defaultLocale = "en_US.UTF-8";

  users.users.dashing = {
    isNormalUser = true;
    description = "dashing";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    htop
    git
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

  # NodeJS untuk aplikasi dashboard

  services.openssh.enable = true;

  system.stateVersion = "25.11";
}
