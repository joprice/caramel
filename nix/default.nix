{ pkgs }:

with pkgs;
let
  ocamlPackages = ocaml-ng.ocamlPackages_4_11;
  ocaml = ocamlPackages.ocaml;
  opam2nix = import ./opam2nix.nix {
    ocamlPackagesOverride = ocamlPackages;
  };
  args = {
    inherit ocaml;
    selection = ./opam-selection.nix;
    src = ../.;
  };
  resolve = opam2nix.resolve args [
    "caramel.opam"
    "erlang.opam"
  ];
  selection = opam2nix.build args;
in
{
  inherit opam2nix pkgs resolve;
  inherit (ocamlPackages) merlin;
  inherit (selection) caramel;
}
