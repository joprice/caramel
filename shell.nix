let
  default = (import ./default.nix {});
  pkgs = default.pkgs;
  inputs = (
    drv: (drv.buildInputs or []) ++ (drv.propagatedBuildInputs or [])
  );
in
pkgs.stdenv.mkDerivation {
  name = "caramel-shell";
  buildInputs = inputs default.caramel;
}
