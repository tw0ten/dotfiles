{
  ...
}:

{
  boot.loader.raspberry-pi.bootloader = "kernel";
  hardware.enableRedistributableFirmware = true;

  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
  };

  swapDevices = [
    {
      device = "/swapfile";
      size = 4096;
    }
  ];

  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 10d";
    };

    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };

    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  imports = [
    /etc/nixos/configuration.nix
  ];
}
