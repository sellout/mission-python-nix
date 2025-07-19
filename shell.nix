{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  packages = [
    (pkgs.python3Full.withPackages (pypkgs: [pypkgs.pgzero]))
    pkgs.unzip
  ];

  shellHook = ''
    if [ ! -f escape.zip ]; then
      ## get the game
      curl https://nostarch.com/download/escape.zip --output escape.zip
      unzip escape.zip
    fi
  '';
}
