{
  lib,
  buildGoModule,
  fetchFromGitHub,
  makeWrapper,
  git,
}:
buildGoModule {
  pname = "nippo";
  version = "0.2.1";

  src = fetchFromGitHub {
    owner = "nurazon59";
    repo = "nippo";
    rev = "3397183f16cd635afe61d43b01476db42738a77c";
    hash = "sha256-b9CBU/DRleeU0io4FkYYwic9vQbEkUkZrc01LDY2fIA=";
  };

  vendorHash = "sha256-TAb9WYdgnjGuhpOvResGXU2P5FoD4p5tVwyTQ8qMdBo=";
  subPackages = [ "." ];
  ldflags = [
    "-s"
    "-w"
  ];

  nativeBuildInputs = [ makeWrapper ];
  nativeCheckInputs = [ git ];

  preCheck = ''
    export XDG_CONFIG_HOME="$TMPDIR/config"
    export XDG_DATA_HOME="$TMPDIR/data"
  '';

  checkPhase = ''
    runHook preCheck
    go test ./...
    runHook postCheck
  '';

  postInstall = ''
    wrapProgram "$out/bin/nippo" --prefix PATH : ${lib.makeBinPath [ git ]}
  '';

  meta = {
    description = "Manage daily reports from the command line";
    homepage = "https://github.com/nurazon59/nippo";
    license = lib.licenses.mit;
    mainProgram = "nippo";
    platforms = [
      "aarch64-darwin"
      "aarch64-linux"
      "x86_64-linux"
    ];
  };
}
