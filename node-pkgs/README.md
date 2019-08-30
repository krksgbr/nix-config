workflow:
1. add package to packages.json
2. regenerate nix files with node2nix

``` shell
node2nix -i packages.json
```
3. rebuild home

``` shell
home-manager rebuild-switch
```
