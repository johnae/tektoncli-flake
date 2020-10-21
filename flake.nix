{
  description = "The tekton cli";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.tektoncli = {
    url = "github:tektoncd/cli/v0.13.0";
    flake = false;
  };

  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    {
      overlay = final: prev: {
        tektoncli = final.callPackage ./. { inherit self; };
      };
    } // (
      flake-utils.lib.eachDefaultSystem
        (system:
          let
            pkgs = import nixpkgs {
              inherit system;
              overlays = [ self.overlay ];
            };
            defaultPackage = pkgs.tektoncli;
            tektoncli = flake-utils.lib.mkApp {
              drv = defaultPackage;
              exePath = "/bin/tkn";
            };
          in
          {
            inherit defaultPackage;
            packages = flake-utils.lib.flattenTree {
              tektoncli = defaultPackage;
            };
            apps.tektoncli = tektoncli;
            defaultApp = tektoncli;
            devShell = import ./shell.nix { inherit pkgs; };
          }
        )
    );
}
