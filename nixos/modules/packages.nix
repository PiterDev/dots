
{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # === Hyprland ===
    wofi
    hyprpaper
    waybar
    xwayland

    # === Glorious Web Browser ===
    firefox
    
    # === Notes ===
    obsidian

    # === Dev Tools ===
    unstable.neovim 
    git
    docker
    
    gcc14

    # === Utilities ===
    pavucontrol
    nautilus
    loupe
    unzip
    file-roller
    swaynotificationcenter
    qdirstat

    grim
    slurp
    wl-clipboard
    keepassxc
    
    # === Terminal ===
    kitty
    zsh
    oh-my-zsh
    
    stow
    tldr
    
    # === Fun ===
    spotify
    fastfetch
    
    # === Nvidia ===
    egl-wayland
  ];


  # Programs idk
  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };

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
    
    steam = {
      enable = true;
    };
  };   

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = ["JetBrainsMono"]; })
    jetbrains-mono
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  
}

