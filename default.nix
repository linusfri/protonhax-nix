{
  lib,
  stdenv,
  fetchFromGitHub,
  steam-run,
}:
stdenv.mkDerivation rec {
  pname = "protonhax";
  version = "1.0.5";

  src = fetchFromGitHub {
    owner = "jcnils";
    repo = pname;
    rev = version;
    sha256 = "sha256-5G4MCWuaF/adSc9kpW/4oDWFFRpviTKMXYAuT2sFf9w=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp protonhax $out/bin
  '';

  postFixup = ''
    sed -i '1s/#!/#!${lib.escape ["/"] (lib.getExe steam-run)} /' $out/bin/protonhax
  '';

  meta = {
    description = "All credits for this goes to https://github.com/pneg.";
    homepage = "https://github.com/jcnils/protonhax";
    mainProgram = "protonhax";
  };
}
