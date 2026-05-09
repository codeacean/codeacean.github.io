{
  description = "walter's website";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [ pkgs.zola ];
          shellHook = ''
            echo "Zola $(zola --version) ready"
          '';
        };

        packages.default = pkgs.stdenv.mkDerivation {
          name = "walter-site";
          src = ./.;
          nativeBuildInputs = [ pkgs.zola ];
          preBuild = ''
            # mkdir -p themes/zerene
          '';
          buildPhase = "zola build";
          installPhase = "cp -r public $out";
        };

        apps.default = {
          type = "app";
          program = "${pkgs.writeShellScript "serve" ''
            # mkdir -p themes/zerene
            # git clone https://github.com/voidwalter/zerene.git ./themes/zerene/
            ${pkgs.zola}/bin/zola serve
          ''}";
        };
      });
}
