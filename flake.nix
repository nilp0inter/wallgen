{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  description = "A very basic flake";

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      flake = {
        # Put your original flake attributes here.
      };
      systems = [ "x86_64-linux" ];
      perSystem = { pkgs, ... }: {
        packages = rec {
          wallgen = with pkgs.python3Packages; buildPythonApplication {
            pname = "wallgen";
            version = "1.0";
            format = "setuptools";
            src = ./.;
            propagatedBuildInputs = [ 
              pillow
              click
              scipy
              flask
              gevent
              numpy
              scikitimage
              loguru
            ];
          };
          default = wallgen;
        };
      };
    };
}
