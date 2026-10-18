{ pkgs }:
{
  ghmux = pkgs.callPackage ./ghmux/package.nix { };
  nippo = pkgs.callPackage ./nippo/package.nix { };
  pull-request-review-context = pkgs.callPackage ./pull-request-review-context/package.nix { };
  rport = pkgs.callPackage ./rport/package.nix { };
  nerd-fonts-0xproto-nurazon59 = pkgs.callPackage ./nerd-fonts-0xproto-nurazon59/package.nix { };
}
