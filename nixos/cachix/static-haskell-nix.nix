
{
  nix = {
    settings.substituters = [
      "https://static-haskell-nix.cachix.org"
    ];
    settings.trusted-public-keys = [
      "static-haskell-nix.cachix.org-1:Q17HawmAwaM1/BfIxaEDKAxwTOyRVhPG5Ji9K3+FvUU="
    ];
  };
}
    
