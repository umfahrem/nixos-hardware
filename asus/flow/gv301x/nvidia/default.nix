{ lib,
  pkgs,
  config,
  ...
}:

let
  inherit (lib) mkDefault;

in {
  imports = [
    ../shared.nix
    ## "prime.nix" loads this, aleady:
    # ../../../common/gpu/nvidia
    ../../../../common/gpu/nvidia/prime.nix
    ../../../../common/gpu/nvidia/ampere

  ];

  # NVIDIA GeForce RTX 4070 Mobile

  boot = {
    blacklistedKernelModules = [ "nouveau" ];
  };

  

  hardware = {
    ## Enable the Nvidia card, as well as Prime and Offload:
    amdgpu.initrd.enable = mkDefault true;

    nvidia = {

      modesetting.enable = true;
      nvidiaSettings = mkDefault true;

      prime = {
        offload = {
          enable = mkDefault true;
          enableOffloadCmd = mkDefault true;
        };
        amdgpuBusId = "0@8:0:0";
        nvidiaBusId = "1@1:0:0";
      };

      powerManagement = {
        enable = mkDefault true;
        finegrained = mkDefault true;
      };

      dynamicBoost.enable = mkDefault true;
      
    };
  };
}
