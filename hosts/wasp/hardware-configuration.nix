{
  lib,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot = {
    loader.grub = {
      enable = true;
      device = "/dev/vda";
    };
    kernelParams = [
      "console=ttyS0"
      "panic=1"
      "boot.panic_on_fail"
    ];
    initrd.availableKernelModules = [
      "virtio_pci"
      "virtio_scsi"
      "virtio_net"
    ];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
    autoResize = true;
  };

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
