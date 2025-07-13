{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  packages = [
    pkgs.python3Full
    pkgs.unzip
  ];

  LD_LIBRARY_PATH = pkgs.lib.concatStringsSep ":" [
    "$LD_LIBRARY_PATH"
    "${pkgs.glib.out}/lib"
    "${pkgs.libgcc.lib}/lib"
    "${pkgs.libz.out}/lib"
  ];

  shellHook = ''
    if [ -f .venv/bin/activate ]
    then source .venv/bin/activate
    else source ./setup
    fi
  '';
}
