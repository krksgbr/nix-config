config: inputs:
let
  myOverlay = self: super:
    {
      stable = import inputs.nixpkgs-stable {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };

      mkScript = (scriptName: file:
        let
          txt = builtins.readFile file;
        in
        self.writeShellScriptBin scriptName ''
          ${txt}
        ''
      );

      htop-vim = super.htop.overrideAttrs (oldAttrs: {
        name = "htop-vim";
        # patches = (oldAttrs.patches or [ ]) ++ [ ./htop-vim.patch ];
      });

      networkmanager_dmenu = super.networkmanager_dmenu.overrideAttrs (oldAttrs: {
        patches = (oldAttrs.patches or [ ]) ++ [ ./networkmanager-dmenu.patch ];
      });

      break-time = (import
        (builtins.fetchTarball {
          url = "https://github.com/cdepillabout/break-time/tarball/5f1f43a464780043318d9f4df0df6f8e8c99accf";
          sha256 = "0rvp891bkc89icf39xpac0sqfxj6dxia3fscw9065598bn0ciwd6";
        }));
    };
in
[
  myOverlay
  (
    import (
      builtins.fetchGit {
        url = "https://github.com/nix-community/emacs-overlay";
        rev = "7b8f58785051e2dd729c9a3a6398920e86c24c13"; # 2020-04-14
      }
    )
  )
]
