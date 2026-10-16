{ pkgs }:
{
  ghmux = pkgs.callPackage ./ghmux/package.nix { };
  nippo = pkgs.callPackage ./nippo/package.nix { };
  rport = pkgs.callPackage ./rport/package.nix { };
}
