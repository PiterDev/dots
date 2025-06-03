
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
    rofi
    feh
    # polybar


    # === Glorious Web Browser ===
    firefox
    
    # === Apps ===
    obsidian
    discord

    # === Dev Tools ===
    unstable.neovim 
    git
    docker
    
    gcc14

    # === Utilities ===
    pavucontrol
    bluetuith
    xfce.thunar
    loupe
    unzip
    file-roller
    dunst
    qdirstat

    scrot
    xclip
    arandr

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
  ];


  # Programs idk
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

