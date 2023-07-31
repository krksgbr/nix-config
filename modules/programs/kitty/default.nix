{ isDarwin, ... }:
{
  imports = [
    (if isDarwin then ./darwin.nix else ./linux.nix)
  ];
}
