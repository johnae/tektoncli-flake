## A Nix flake for the tekton cli

More info forthcoming but usage is what you'd expect. Just running tkn would require you to have [Nix](https://nixos.org) installed and configured with the still experimental flake support. In /etc/nix/nix.conf you'd need this line basically:

```
experimental-features = nix-command flakes ca-references
```

For that to work, you also need to use the ```nixUnstable``` package.