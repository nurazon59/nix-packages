{
  lib,
  stdenvNoCC,
  fetchurl,
}:
stdenvNoCC.mkDerivation {
  pname = "nerd-fonts-0xproto-nurazon59";
  version = "2.501-nurazon59.1";

  src = fetchurl {
    url = "https://github.com/nurazon59/0xProto/releases/download/2.501-nurazon59.1/0xProto.tar.xz?download=1";
    hash = "sha256-7/qkwlfB8l5tLVBnnpuEXqs2s0beqe4m9EBdoaIeZCg=";
  };

  sourceRoot = ".";

  installPhase = ''
    install -d "$out/share/fonts/truetype"
    find . -type f -name '*.ttf' -exec install -m644 {} "$out/share/fonts/truetype/" \;
    install -Dm644 LICENSE "$out/share/licenses/$pname/LICENSE"
  '';

  meta = {
    description = "0xProto Nerd Font from nurazon59's personal release";
    homepage = "https://github.com/nurazon59/0xProto";
    license = lib.licenses.ofl;
    platforms = [
      "aarch64-darwin"
      "aarch64-linux"
      "x86_64-linux"
    ];
  };
}
