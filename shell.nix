{pkgs}:
pkgs.mkShellNoCC {
  nativeBuildInputs = with pkgs; [
    alejandra
    bazel_6
    bazel-buildtools
    go
  ];
}
