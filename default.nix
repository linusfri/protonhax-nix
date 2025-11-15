{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  name = "protonhax-nix";
  src = fetchGit {
    url = "https://github.com/jcnils/protonhax";
    rev = "922a7bbade5a93232b3152cc20a7d8422db09c31";
  };

  doUnpack = false;

  nativeBuildInputs = with pkgs; [
    makeWrapper
  ];

  buildInputs = with pkgs; [
    coreutils
    gnugrep
  ];

  installPhase = ''
    mkdir -p $out/bin
    cat $src/protonhax > $out/bin/protonhax

    sed -i 's|#!/bin/bash|#!/usr/bin/env bash|g' $out/bin/protonhax
    chmod +x $out/bin/protonhax

    wrapProgram $out/bin/protonhax \
      --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.coreutils pkgs.gnugrep ]}
  '';
}