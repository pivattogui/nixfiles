{ config, pkgs, ... }:
{
  # Enable NVIDIA drivers
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Use production drivers (stable)
    package = config.boot.kernelPackages.nvidiaPackages.production;

    # Modesetting is required for Wayland
    modesetting.enable = true;

    # Enable 32-bit support for compatibility (games, Wine, etc.)
    prime.offload.enable = false;

    # Open source kernel modules (set to false for proprietary)
    open = false;

    # Enable nvidia-settings menu
    nvidiaSettings = true;
  };

  # Enable OpenGL with 32-bit support
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
