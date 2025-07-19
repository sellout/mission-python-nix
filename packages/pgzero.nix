{
  buildPythonPackage,
  fetchPypi,
  numpy,
  pygame,
  setuptools,
  setuptools-scm,
}: let
  pname = "pgzero";
  version = "1.2.1";
in
  buildPythonPackage {
    inherit pname version;
    pyproject = true;
    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-jK3AIPAoy6w+DL07uTEaHARfHe7ax5F/9DP5hsOOYQY=";
    };
    build-system = [
      setuptools
      setuptools-scm
    ];
    dependencies = [
      numpy
      pygame
    ];
  }
