{
  description = "Protonhax for nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      inherit (pkgs) callPackage;
    in
    {

      packages.x86_64-linux.protonhax-nix = callPackage ./. { };

      packages.x86_64-linux.default = self.packages.x86_64-linux.protonhax-nix;

    };
}
