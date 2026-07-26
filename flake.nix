{
  description = "Flake for the site management";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        # Development shell with Zola
        devShells.default = pkgs.mkShell {
          packages = [ pkgs.zola ];

          shellHook = ''
            echo "Zola ${pkgs.zola.version} is ready."
            echo "Ensure 'themes/zerene' exists in your project directory."
            echo "Run 'zola serve' to start the local server."
          '';
        };

        # Optional: Package to build the site assuming theme exists locally
        packages.website = pkgs.stdenv.mkDerivation {
          pname = "zola-site";
          version = "0.1.0";
          src = ./.;
          nativeBuildInputs = [ pkgs.zola ];
          buildPhase = "zola build";
          installPhase = "cp -r public $out";
        };
      }
    );
}
