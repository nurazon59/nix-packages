{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule {
  pname = "rport";
  version = "0-unstable-2026-03-04";

  src = fetchFromGitHub {
    owner = "nurazon59";
    repo = "rport";
    rev = "320b1fc5bf052379130b172655f2a1d8a7798c81";
    hash = "sha256-5B0a4gIKEV/68x1x73jp6eStjuvNQtexq3jj+dGrYno=";
  };

  vendorHash = null;
  subPackages = [ "." ];
  ldflags = [
    "-s"
    "-w"
  ];

  meta = {
    description = "Pick an available local TCP port";
    homepage = "https://github.com/nurazon59/rport";
    license = lib.licenses.mit;
    mainProgram = "rport";
    platforms = [
      "aarch64-darwin"
      "aarch64-linux"
      "x86_64-linux"
    ];
  };
}
