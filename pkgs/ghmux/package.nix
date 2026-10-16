{
  lib,
  buildGoModule,
  fetchFromGitHub,
  makeWrapper,
  git,
  gh,
}:
buildGoModule {
  pname = "ghmux";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "nurazon59";
    repo = "ghmux";
    rev = "fad06c318f0fc12b7b3236f59d4fec6fef083fc7";
    hash = "sha256-c0ho45W1OCkdJDDA1d08UmVwwtXsBtOkFcWw3tWpHlA=";
  };

  vendorHash = "sha256-komX1AmHt2NoF1x6xsNa2RFkfVzOXfYEMPhT0zwMxjw=";
  subPackages = [ "." ];
  ldflags = [
    "-s"
    "-w"
  ];

  nativeBuildInputs = [ makeWrapper ];

  postInstall = ''
    wrapProgram "$out/bin/ghmux" --prefix PATH : ${
      lib.makeBinPath [
        git
        gh
      ]
    }
  '';

  meta = {
    description = "CLI for managing multiple GitHub accounts";
    homepage = "https://github.com/nurazon59/ghmux";
    license = lib.licenses.mit;
    mainProgram = "ghmux";
    platforms = [
      "aarch64-darwin"
      "aarch64-linux"
      "x86_64-linux"
    ];
  };
}
