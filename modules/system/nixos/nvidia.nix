{ config, ... }:
{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.production;
    modesetting.enable = true;
    prime.offload.enable = false;
    open = false;
    nvidiaSettings = true;
    powerManagement.enable = true;
    nvidiaPersistenced = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
