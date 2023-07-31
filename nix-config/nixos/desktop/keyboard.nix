{ config, lib, pkgs, ... }:

{
  services.xserver = {
    layout = "us";
    xkbOptions = "eurosign:e,ctrl:nocaps";
  };


  # TODO remap tilde (nl apple keyboard layout)
  # https://superuser.com/questions/245138/linux-ubuntu-apple-aluminium-keyboard-remap-greater-less-with-tilde
  # https://nixos.wiki/wiki/Keyboard_Layout_Customization
  # https://stackoverflow.com/questions/40529774/tilde-key-not-working-in-fedora-linux-on-macbook-air
  hm.xsession.initExtra =
    let
      keyboard-mods = pkgs.writeText "keyboard-mods" ''
        keycode 94 = grave asciitilde
        keycode 49 = section plusminus
      '';
      cmd = "sleep 5 && ${pkgs.xorg.xmodmap}/bin/xmodmap ${keyboard-mods}";
    in
    # Run cmd in another shell to no block startup
    "bash -c '${cmd}' &";

  hm = {
    home.keyboard = null;
  };
  # This will apply the X keymap to the console keymap,
  # which affects virtual consoles such as tty
  # https://unix.stackexchange.com/questions/377600/in-nixos-how-to-remap-caps-lock-to-control
  console.useXkbConfig = true;
}
