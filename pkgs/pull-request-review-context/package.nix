{
  lib,
  buildGoModule,
  fetchFromGitHub,
  makeWrapper,
  git,
  gh,
}:
buildGoModule {
  pname = "pull-request-review-context";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "nurazon59";
    repo = "pull-request-review-context";
    rev = "69344248120c7bb770da5ee16a8000eb384baf88";
    hash = "sha256-7YH7tF9vnje1VPcpQCDkMF6X8cqKQohdzU9e54DP6Dc=";
  };

  vendorHash = "sha256-/jneuFBAvGOwX9oIBGOmCmBdtmOPIVT4PgP5qLlWprw=";
  subPackages = [ "cmd/pull-request-review-context" ];
  ldflags = [
    "-s"
    "-w"
  ];

  nativeBuildInputs = [ makeWrapper ];

  checkPhase = ''
    runHook preCheck
    go test ./...
    runHook postCheck
  '';

  postInstall = ''
    wrapProgram "$out/bin/pull-request-review-context" --prefix PATH : ${
      lib.makeBinPath [
        git
        gh
      ]
    }
  '';

  meta = {
    description = "Extract pull request review comments and target code lines for LLM context";
    homepage = "https://github.com/nurazon59/pull-request-review-context";
    license = lib.licenses.mit;
    mainProgram = "pull-request-review-context";
    platforms = [
      "aarch64-darwin"
      "aarch64-linux"
      "x86_64-linux"
    ];
  };
}
