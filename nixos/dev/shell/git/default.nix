{ config, lib, pkgs, ... }:
let
  commitTemplate = ".config/git/gitmessage";
in
{
  imports = [
    ./delta.nix
    ./scripts.nix
  ];
  hm.programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Gábor Kerekes";
    userEmail = "krks.gbr@gmail.com";
    extraConfig = {
      core.autocrlf = "input";
      core.editor = "vim";
      GitHub.user = "krksgbr";
      push.default = "simple";
      commit.template = "~/${commitTemplate}";
      alias = {
        ppr = "!f() { git pull upstream refs/pull/`git symbolic-ref --short HEAD | awk -F'/' '{print $2}'`/head;  }; f";
        lg = "log --graph --pretty=format:'%C(yellow)%h -%C(auto)%d %C(bold cyan)%s %Creset %C(white)(%cr)%Creset %C(dim white)%an'";
      };
      init.defaultBranch = "main";
      user.signingkey = "3E64E0EC968DEB05";
      commit.gpgsign = true;
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
      "todo.org"
      ".direnv/"

      # ts-server log
      ".log"

      # scala stuff
      ".bloop"
      ".metals"
      "project/.bloop"

      # dividat-specific
      "backend/project/metals.sbt"
      "backend/project/project"
      ".envrc"
    ];
  };


  hm.home.file."${commitTemplate}".text = ''
    # [Add/Fix/Remove/Update/Refactor/Document] [summary]
    # Why is it necessary? (Bug fix, feature, improvements?)
    # How does the change address the issue?
    # What side effects does this change have?
    # Include a link to the ticket, if any.
  '';
}
