{
  buildBazelPackage,
  lib,
  pkgs,
}:
buildBazelPackage {
  name = "nixbazelgotemplate";

  bazel = pkgs.bazel_6;
  bazelTargets = ["cmd/nixbazelgotemplate:nixbazelgotemplate"];
  bazelFlags = ["--config=nix"];

  nativeBuildInputs = with pkgs; [nix];
  buildInputs = with pkgs; [cacert];
  buildAttrs = {
    installPhase = ''
      install -Dm755 bazel-bin/cmd/nixbazelgotemplate/nixbazelgotemplate_/nixbazelgotemplate $out/bin/nixbazelgotemplate
    '';
  };

  src = pkgs.nix-gitignore.gitignoreSource [] (lib.cleanSource ./.);
  fetchAttrs.sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
}
