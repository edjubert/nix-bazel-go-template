{
  buildBazelPackage,
  lib,
  pkgs,
}:
buildBazelPackage {
  name = "nixbazelgotemplate";

  bazel = pkgs.bazel_6;
  bazelTargets = ["//cmd/nixbazelgotemplate:nixbazelgotemplate"];
  bazelFlags = ["--explain=nixbuild.log" "--verbose_explanations"];

  nativeBuildInputs = with pkgs; [nix go];
  buildInputs = with pkgs; [cacert];
  buildAttrs = {
    installPhase = ''
      install -Dm755 bazel-bin/cmd/nixbazelgotemplate/nixbazelgotemplate_/nixbazelgotemplate $out/bin/nixbazelgotemplate
    '';
  };

  src = pkgs.nix-gitignore.gitignoreSource [] (lib.cleanSource ./.);
  fetchAttrs.sha256 = "sha256-m/ue5ZUeadQz6iIVr2San2NyPLA1ja2rA7XA24cmm2A=";
}
