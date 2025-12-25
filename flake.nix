{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { self, flake-utils, nixpkgs, rust-overlay }:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system: let
      pkgs = import nixpkgs {
        inherit system;
          overlays = [
            rust-overlay.overlays.default
          ];
      };
      my-rust = pkgs.rust-bin.stable.latest.default.override {
        extensions = [
          "rust-src"
        ];
      };

    in {
      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          git

          my-rust
          rust-analyzer
        ];
      };
    });
}
