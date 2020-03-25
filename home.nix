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
    ./dunst
    ./compton.nix
  ];

  home.packages = with pkgs; []
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
      emacs = import ./emacs {};
    in
      {
        ".vimrc".source = ./dot/vimrc;
        # ".vim/autoload/plug.vim".source = fetchurl {
        #    url = "https://raw.githubusercontent.com/junegunn/vim-plug/ebd534c88bfd49f8d3c758d96ad04ce3f77ee6f8/plug.vim";
        #    sha256 = "1yd9dbbrkybgplnw96390g2d0w0wcl4amd2kjhxrqvnjricggzvj";
        # };
        ".config/compton.conf".source = ./compton.conf;
        "bin/rofi-logout".source = ./rofi/rofi-logout; # expected by i3
        "bin/rofi-kbd-layout".source = ./rofi/rofi-kbd-layout; # expected by i3
        # ".config/i3".source = ./i3;
        ".config/polybar".source = ./polybar;
        ".config/kitty".source = ./kitty;
        ".config/gtk-3.0".source = ./gtk-3.0;
        ".config/networkmanager-dmenu".source = ./networkmanager-dmenu;
        ".local/share/fonts".source = import ./fonts { inherit pkgs; };
        #".emacs.d".source = emacs.emacs-d;
        # ".doom.d".source = emacs.doom-d;
        ".ideavimrc".source = ./dot/ideavimrc;
      };

  xsession.enable = true;
  xsession.windowManager.i3 = {
    enable = true;
    extraConfig = builtins.readFile ./i3/config;
    config.bars = [];
    config.modifier = "Mod4";
    config.keybindings = {};
  };


  programs.emacs = {
    enable = true;
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

  programs.git = {
    enable = true;
    userName = "Gábor Kerekes";
    userEmail = "krks.gbr@gmail.com";
    extraConfig = {
      core.autocrlf = "input";
      core.editor = "vim";
      GitHub.user = "krksgbr";
      push.default = "simple";
    };
    ignores = [
      ".DS_Store"
      "*.iml"
      ".idea/"
      "bower_components/"
      "node_modules/"
      "npm-debug.log"
      ".tern-port"
      ".projectile"
      "flymd*"
      "*~"
      "*.swp"
      ".krks-private"
    ];
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

}
