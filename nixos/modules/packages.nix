
{ config, pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
   neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
   git
   pavucontrol
   nautilus
   zsh
   oh-my-zsh
   gnome-screenshot
   scrot
   xclip
   stow

   xorg.xrandr
   arandr
  #  wget
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

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  
}

