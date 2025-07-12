{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./fzf
    ./git
    ./neovim
    ./zellij # terminal multiplexing
    ./navi # cheatsheets for code and cli tools
  ];

  hm = {
    home.packages = with pkgs; [
      jq
      curl
      imagemagick
      exiftool
      procs
      just
      chezmoi
    ];

    programs = {
      bat = {
        enable = true;
        extraPackages = with pkgs.bat-extras; [
          batman # View man pages through bat
        ];
      };

      direnv = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
      };

      eza = {
        enable = true;
        enableZshIntegration = true;
      };

      zsh.initContent = ''
        # chezmoi completion widget
        eval "$(chezmoi completion zsh)"
      '';
    };
  };

  my.shell.aliases = {
    cat = ''bat --theme="Solarized (dark)"'';
    tree = "eza --tree";
  };

  homebrew = lib.mkIf pkgs.stdenv.isDarwin {
    casks = ["ghostty"];
  };
}
