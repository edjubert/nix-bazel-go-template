{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = {
    self,
    flake-utils,
    nixpkgs,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {inherit system;};
      in {
        devShells.default = pkgs.callPackage ./shell.nix {};
        packages.nixbazelgotemplate = pkgs.callPackage ./package.nix {};
      }
    );
}
