{ pkgs ? import <nixpkgs> {} }: 
  {
    emacs-d = builtins.fetchGit {
      url = "https://github.com/hlissner/doom-emacs.git";
      rev = "d8dbd0759cad2b1c52bf6dc3019a55cb2850408e";
    };
    doom-d = ./doom.d;
  }
