{ config, lib, pkgs, ... }:
let
  commitTemplate = ".gitmessage";
in
{
  imports = [
    ./delta.nix
  ];
  programs.git = {
    enable = true;
    userName = "Gábor Kerekes";
    userEmail = "krks.gbr@gmail.com";
    extraConfig = {
      core.autocrlf = "input";
      core.editor = "vim";
      GitHub.user = "krksgbr";
      push.default = "simple";
      commit.template = "~/${commitTemplate}";
      alias = {
        pr = "!f() { git fetch -fu upstream refs/pull/$1/head:pr/$1 && git checkout pr/$1; }; f";
      };
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
    ];
  };

  home.file.".gitmessage".text = ''
    # [Add/Fix/Remove/Update/Refactor/Document] [summary]
    # Why is it necessary? (Bug fix, feature, improvements?)
    # How does the change address the issue?
    # What side effects does this change have?
    # Include a link to the ticket, if any.
  '';
}
