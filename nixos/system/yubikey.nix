{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # yubikey-manager
    yubikey-manager-qt
    # yubioath-desktop
    yubikey-personalization
  ];

  # Use gpg-agent instead of ssh agent
  programs.ssh.startAgent = false;

  # SSH-agent
  environment.shellInit = ''
    gpg-connect-agent /bye
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  '';

  services = {

    # Support for smartcards
    pcscd.enable = true;

    # To access the yubikey as a user
    udev.packages = with pkgs; [ yubikey-personalization ];

    # Required ?
    # boot.blacklistedKernelModules = [ "pn533_usb" "pn533" "nfc" ];

  };

}
