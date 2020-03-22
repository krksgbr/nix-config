{
  shellAliases = {
    nrs = "sudo nixos-rebuild switch";
    hrs = "home-manager switch";
    idea = "idea-community";
    conf = "emacs ~/.config/nixpkgs & disown";
    ls = "ls --color=auto";
    grep = "grep --color=always";
    halup = "ssh -t gbr@ssh.krks.info '~/halu.space/exec_pms.sh'";
    halucp = "rsync -avzP --remove-source-files --omit-dir-times ~/halu.stage/ gbr@ssh.krks.info:";
    play = "chromium --kiosk http://localhost:8080";
    clip = "xclip -selection clipboard";
  };
  sessionVariables = {
    HOME_CONFIG_DIR = "$HOME/.config/nixpkgs";
  };
}
