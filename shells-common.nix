{
  shellAliases = {
    nrs = ''cd $HOME/nix-config/ && sudo nix-shell shell.nix --command "sudo nixos-rebuild switch --flake '.#'" && cd -'';
    nrt = ''cd $HOME/nix-config/ && sudo nix-shell shell.nix --command "sudo nixos-rebuild test --flake '.#'" && cd -'';
    hrs = "home-manager switch";
    idea = "idea-community";
    conf = "emacs ~/nix-config & disown";
    ls = "ls --color=auto";
    grep = "grep --color=always";
    halup = "ssh -t gbr@ssh.krks.info '~/halu.space/exec_pms.sh'";
    halucp = "rsync -avzP --remove-source-files --omit-dir-times ~/halu.stage/ gbr@ssh.krks.info:";
    play = "chromium --kiosk http://localhost:8080";
    clip = "xclip -selection clipboard";
    mkinvoice = "node ~/projects/invoicer/run.js";
  };
  sessionVariables = {
    HOME_CONFIG_DIR = "$HOME/.config/nixpkgs";
    EDITOR = "vim";
  };
}
