{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      inputs = with pkgs; [
        gnumake
        gcc
        readline
        openssl
        zlib
        libxml2
        curl
        libiconv
        glibcLocales
        postgresql
        clojure
        leiningen
      ] ++ lib.optional stdenv.isLinux [
        inotify-tools
        gtk-engine-murrine
      ];
    in
    rec {
      devShells = {
        "${system}".default = with pkgs; mkShell {
          name = "hofund";
          buildInputs = inputs;
        };
      };
    };
}
