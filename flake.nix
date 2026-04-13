{
  description = "walter's website";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    zerene = {
      url = "github:voidwalter/zerene";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, zerene }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [ pkgs.zola ];
          shellHook = ''
            echo "Zola $(zola --version) ready"
            echo "  zola serve   — local dev server"
            echo "  zola build   — build to ./public"
          '';
        };

        packages.default = pkgs.stdenv.mkDerivation {
          name = "walter-site";
          src = ./.;
          nativeBuildInputs = [ pkgs.zola ];
          preBuild = ''
            mkdir -p themes/zerene
            cp -rT ${zerene} themes/zerene
          '';
          buildPhase = "zola build";
          installPhase = "cp -r public $out";
        };

        apps.default = {
          type = "app";
          program = "${pkgs.writeShellScript "serve" ''
            mkdir -p themes/zerene
            cp -rT ${zerene} themes/zerene
            ${pkgs.zola}/bin/zola serve
          ''}";
        };
      });
}
