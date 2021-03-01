with builtins;
{ config, pkgs, ... }:
let
  shellsCommon = import ./shells-common.nix;
in
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  imports = [
    ./zsh
    ./rofi
    ./redshift
    ./notifications
    ./compton.nix
    ./git
  ];

  nixpkgs.overlays = import ./nixos/overlays.nix config;

  home.packages = with pkgs; [
    (mkScript "torrents" ./deluge.sh)
  ]
  ++ (
    builtins.attrValues (
      import ./node-pkgs {
        inherit pkgs;
        inherit nodejs;
      }
    )
  );

  home.file =
    let
      emacs = import ./emacs { };
    in
    {
      ".vimrc".source = ./dot/vimrc;
      ".config/compton.conf".source = ./compton.conf;
      "bin/rofi-logout".source = ./rofi/rofi-logout; # expected by i3
      "bin/rofi-kbd-layout".source = ./rofi/rofi-kbd-layout; # expected by i3
      ".config/kitty".source = ./kitty;
      #".config/gtk-3.0".source = ./gtk-3.0;
      ".config/networkmanager-dmenu".source = ./networkmanager-dmenu;
      ".local/share/fonts".source = import ./fonts { inherit pkgs; };
      ".ideavimrc".source = ./dot/ideavimrc;
    };

  xsession.enable = true;
  xsession.windowManager.i3 = {
    enable = true;
    extraConfig = builtins.readFile ./i3/config;
    config.bars = [ ];
    config.modifier = "Mod4";
    config.keybindings = { };
  };

  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3Support = true;
      alsaSupport = true;
      pulseSupport = true;
      nlSupport = true;
    };
    config = ./polybar/config;
    script = "polybar default &";
  };

  xsession.pointerCursor = {
    package = pkgs.vanilla-dmz;
    name = "Vanilla-DMZ-AA";
    size = 128;
  };

  xresources.extraConfig = ''
    Xft.dpi: 210
  '';


  programs.emacs = {
    enable = true;
    # package = pkgs.emacsUnstable;
  };

  programs.zathura = {
    enable = true;
  };

  programs.vim = {
    enable = true;
    extraConfig = builtins.readFile ./dot/vimrc;
    settings = {
      relativenumber = true;
      number = true;
    };
    plugins = with pkgs.vimPlugins; [
      sensible
      surround
      airline
      solarized
      tmux-navigator
      #vim-airline-themes
      #Dockerfile.vim
      #vim-solarized8
      #vim-tmux-navigator
      #kotlin-vim
      #vim-graphql
    ];
  };

  # programs.tmux = {
  #  enable = true;
  # currently incompatible with this setup, because cut '.tmux.conf' in the config file cannot run
  #  extraConfig =
  #    let
  #      tmuxConf = builtins.readFile (fetchurl {
  #        name = "gpakosz-tmux-conf";
  #        url = "https://raw.githubusercontent.com/gpakosz/.tmux/96007b3464a429527defde1924198cf219808f3d/.tmux.conf";
  #        sha256 = "1b83y1rjmjlnqk8690ymg45ljr82vah3w9jxn2p81yvkkawyim14";
  #      });
  #      tmuxConfLocal = builtins.readFile ./dot/tmux.conf.local;
  #    in ''
  #       ${tmuxConf}
  # #       ${tmuxConfLocal}
  # #      '';
  # };


  programs.bash = {
    enable = true;
    shellAliases = shellsCommon.shellAliases;
    sessionVariables = shellsCommon.sessionVariables;
    bashrcExtra = ''
      set -o vi
    '';
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableNixDirenvIntegration = true;
  };

  services.udiskie.enable = true;
}
