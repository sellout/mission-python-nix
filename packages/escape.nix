## TODO: This would ideally be a real Python package that provided the game as
##      `mainProgram`, but for now it is really just a support package for the
##       development shell.
{
  fetchzip,
  lib,
  pgzero,
  stdenv,
}: let
  pname = "escape";
  version = "2017";
in
  stdenv.mkDerivation {
    inherit pname version;

    src = fetchzip {
      url = "https://www.sean.co.uk/downloads/${version}files/${pname}.zip";
      sha256 = "sha256-WJIhR4MRJOalCowhjXpuPZSVsmu7yuJIfT2wQjtw5Ug=";
      stripRoot = false;
    };

    nativeBuildInputs = [
      pgzero
    ];

    buildPhase = ''
      runHook preBuild

      cp -R . "$out"

      runHook postBuild
    '';
  }
