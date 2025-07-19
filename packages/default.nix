{python3Packages}: let
  pgzero = python3Packages.callPackage ./pgzero.nix {};
in {
  inherit pgzero;

  escape = python3Packages.callPackage ./escape.nix {inherit pgzero;};
}
