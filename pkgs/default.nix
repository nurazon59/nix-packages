{ pkgs }:
{
  ghmux = pkgs.callPackage ./ghmux/package.nix { };
  rport = pkgs.callPackage ./rport/package.nix { };
}
