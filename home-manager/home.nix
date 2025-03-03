{ config, pkgs, ... }:

let
  spicetify-nix = import (builtins.fetchTarball {
    url = "https://github.com/Gerg-L/spicetify-nix/archive/refs/heads/master.tar.gz";
    sha256 = "0x8irlr3qfzin6kljniy76svz67rlir74dzw6nn3s54f9j8bgvrm"; 
  }) { inherit pkgs; };

  spicePkgs = spicetify-nix.packages;
in
{


  imports = [
    spicetify-nix.homeManagerModules.default
  ];

  programs.spicetify = {
     enable = true;
     enabledExtensions = with spicePkgs.extensions; [
       hidePodcasts
       shuffle # shuffle+ (special characters are sanitized out of extension names)
     ];
     theme = spicePkgs.themes.ziro;
   };
  
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "piter";
  home.homeDirectory = "/home/piter";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    
    # System basics
    kitty
    brave
    rofi
    vlc

    redshift

    # Programming
    vscode-fhs
    godot_4
    blender
    
    # Compilers and stuff like that
    python3
    uv
    bun
    nodejs-18_x
    nodePackages.pnpm
    
    # Personal
    obsidian
   
    # Entertainment
    # spotify # Spicetify will take care of this, uncomment   
    cava

    # Other tools
    qdirstat

    keepassxc


    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/piotr/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.cava.settings = {
    input.method = "pipewire";
  };

  programs.git = {
    enable = true;

    userEmail = "61157319+PiterDev@users.noreply.github.com";
    userName = "Piter";
  };
  programs.git.extraConfig = {
    init.defaultBranch = "main";
  };
  
  services.redshift = {
    enable = true;
    temperature = {
      day = 5500;
      night = 3500;
    };

    latitude = "53.42894";
    longitude = "14.55302";
    

  };
  
  # nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
