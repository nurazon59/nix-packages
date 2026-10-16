# nix-packages

Nix packages for [nurazon59](https://github.com/nurazon59)'s CLI tools.

Packages build from pinned source revisions with Nixpkgs builders. The flake
exposes `packages.<system>.<name>` and `overlays.default` for Apple Silicon
macOS and ARM64/x86-64 Linux. Nix with `nix-command` and `flakes` enabled is
required.

## Packages

| Package | Version | Description |
| --- | --- | --- |
| [ghmux](https://github.com/nurazon59/ghmux) | 0.1.0 | Manage multiple GitHub accounts |
| [rport](https://github.com/nurazon59/rport) | 0-unstable-2026-03-04 | Pick an available local TCP port |

## Usage

Run a package without installing it:

```sh
nix run github:nurazon59/nix-packages#ghmux -- --help
```

Install a package into your profile:

```sh
nix profile install github:nurazon59/nix-packages#ghmux
```

Add the flake to your inputs:

```nix
{
  nurazon59-packages = {
    url = "github:nurazon59/nix-packages";
    inputs.nixpkgs.follows = "nixpkgs";
  };

}
```

Apply its overlay in a NixOS or nix-darwin module with `inputs` passed through
`specialArgs`:

```nix
{ inputs, pkgs, ... }:
{
  nixpkgs.overlays = [ inputs.nurazon59-packages.overlays.default ];
  environment.systemPackages = [ pkgs.ghmux ];
}
```

In Home Manager, use `home.packages = [ pkgs.ghmux ];` after applying the
overlay to its package set. Packages are also accessible directly through
`inputs.nurazon59-packages.packages.${pkgs.system}.ghmux`.

## Development

Add a definition in `pkgs/<name>/package.nix` and register it in
`pkgs/default.nix`. Set `meta.mainProgram` so `nix run` can find the executable.
Pin the source revision, source hash, and dependency hash. Update those pins
together when changing a package version.

```sh
nix fmt -- --ci
nix build .#<name>
nix flake check --print-build-logs
```

CI builds and runs each package's enabled checks on ARM64 macOS and x86-64
Linux. ARM64 Linux is exposed for consumers but is not built by CI.

## License

The package definitions are available under the [MIT License](LICENSE).
Packaged software retains its upstream license.
