# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:



{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Custom Hardware Configs
  # Apparently hardware-configuration.nix can get overwritten

  fileSystems."/mnt/ntfs" = 
    { device = "/dev/disk/by-uuid/9232671E32670717";
      fsType = "ntfs";
      options = [ "rw" "uid=1000" ];

    };
  
  boot.supportedFilesystems = [ "ntfs" ];

  # GPU Settings
  hardware.graphics = {
    enable = true;
  };


  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement.enable = true; # Enable if issues show up after suspend/sleep

    powerManagement.finegrained = false; # Turing+

    open = false; # Nvidia open source kernel module (Turing+)

    nvidiaSettings = true; # Nvidia settings menu, accessible via nvidia-settings

    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "pl";
    variant = "";
  };

  services.libinput = {
    enable = true;
    mouse = {
      accelProfile = "flat";
      accelSpeed = "-0.5";
    };
  };

  # Configure console keymap
  console.keyMap = "pl2";

  # Configure PipeWire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

  };

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.piotr = {
    isNormalUser = true;
    description = "Piotr";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];

    shell = pkgs.zsh;
  };

  # Experimental features
  # TODO: Become a nix-command chad
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
   neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
   git
   pavucontrol
   xfce.thunar
   zsh
   oh-my-zsh
   gnome-screenshot
   scrot
   xclip
   stow
  #  wget
  ];

  # Xorg
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    
    windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [
        luarocks
      ];
    };
  };
  
  ## Programs idk
  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
      
    };

    zsh = {
      enable = true;
      ohMyZsh = {
        enable = true;
	plugins = [ "git" ];
	theme = "robbyrussell";
      };

      shellAliases = {
        update = "sudo nixos-rebuild switch && ~/dotfiles/backup.sh";
      };
    };
  };   

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
