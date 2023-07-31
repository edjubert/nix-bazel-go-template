# Nix + Bazel + Go template
Currently this template is not working, I'm still trying to resolve an issue on how to build with Nix toolchain.

## Errors
There is no error when building project via Bazel:
```bash
$ bazel build --config=nix //cmd/nixbazelgotemplate:nixbazelgotemplate
WARNING: The following configs were expanded more than once: [nix]. For repeatable flags, repeats are counted twice and may lead to unexpected behavior.
WARNING: The following configs were expanded more than once: [nix]. For repeatable flags, repeats are counted twice and may lead to unexpected behavior.
INFO: Analyzed target //cmd/nixbazelgotemplate:nixbazelgotemplate (0 packages loaded, 0 targets configured).
INFO: Found 1 target...
Target //cmd/nixbazelgotemplate:nixbazelgotemplate up-to-date:
  bazel-bin/cmd/nixbazelgotemplate/nixbazelgotemplate_/nixbazelgotemplate
INFO: Elapsed time: 0.589s, Critical Path: 0.00s
INFO: 1 process: 1 internal.
INFO: Build completed successfully, 1 total action
```

But this strange error appends when trying to build via nix:
```bash
$ nix build .#nixbazelgotemplate
[1/0/2 built] building nixbazelgotemplate-deps.tar.gz (buildPhase): Analyzing: target //cmd/nixbazelgotemplate:nixbazelgotemperror: builder for '/nix/store/nrn95lki35l99x1skqhya2lqgk8d6pzn-nixbazelgotemplate-deps.tar.gz.drv' failed with exit code 1;
       last 10 log lines:
       >   Package '@sdk_go_nix' outputs a single file which is not supported by rules_nixpkgs. Please only use directories.
       >     Command: "/nix/store/whinz9rj5h6h8zxp9bkmfzv7fkzc0cq8-coreutils-9.3/bin/test" "-d" "/nix/store/qjynhwar1pjwgi4dfkc069a8jjbihmwr-bazel-go-toolchain"
       >     Return code: 1
       >     Error output:
       >
       > ERROR: Analysis of target '//cmd/nixbazelgotemplate:nixbazelgotemplate' failed; build aborted:
       > INFO: Elapsed time: 45.452s
       > INFO: 0 processes.
       > FAILED: Build did NOT complete successfully (45 packages loaded, 260 targets configured)
       >
       For full logs, run 'nix log /nix/store/nrn95lki35l99x1skqhya2lqgk8d6pzn-nixbazelgotemplate-deps.tar.gz.drv'.
error: 1 dependencies of derivation '/nix/store/qdbd6bw5ccwj2jl1gfgxlm0ys6mzcmjb-nixbazelgotemplate.drv' failed to build
```

Here is the result of `nix log /nix/store/nrn95lki35l99x1skqhya2lqgk8d6pzn-nixbazelgotemplate-deps.tar.gz.drv`:
```log
@nix { "action": "setPhase", "phase": "unpackPhase" }
unpacking sources
unpacking source archive /nix/store/8l8l8hcn1jzdrg8cg8jjqyc90hyc47cb-0hc0kj34zdpgmlnn23wbhywlmh37p124-source
source root is 0hc0kj34zdpgmlnn23wbhywlmh37p124-source
@nix { "action": "setPhase", "phase": "patchPhase" }
patching sources
@nix { "action": "setPhase", "phase": "updateAutotoolsGnuConfigScriptsPhase" }
updateAutotoolsGnuConfigScriptsPhase
@nix { "action": "setPhase", "phase": "configurePhase" }
configuring
no configure script, doing nothing
@nix { "action": "setPhase", "phase": "buildPhase" }
building
Extracting Bazel installation...
Loading: 
Loading: 
Loading:
Loading: 0 packages loaded
Analyzing: target //cmd/nixbazelgotemplate:nixbazelgotemplate (1 packages loaded, 0 targets configured)
warning: '/nix/var/nix' does not exist, so Nix will use '/build/.local/share/nix/root' as a chroot store
Analyzing: target //cmd/nixbazelgotemplate:nixbazelgotemplate (45 packages loaded, 260 targets configured)
these 4 derivations will be built:
  /nix/store/ncjc9ppbkah02375xzh0hxl73yxr5pj7-bazel-go-toolchain-go-version.drv
  /nix/store/hh0ss11kiini8ajm0l5l11r9l6lbqdar-builder.pl.drv
  /nix/store/yyr5a7zxj30mgxrwiqa3z0n1la7nn742-bazel-go-toolchain.drv
  /nix/store/35q12y2aq3ph8sh40j5fqfdd9wll9kf1-bazel-go-toolchain.drv
these 39 paths will be fetched (93.75 MiB download, 353.74 MiB unpacked):
  /nix/store/2jdmi86cvcrjrgmjc9mx119zbq278ssi-acl-2.3.1
  /nix/store/65jnw3qlvhpk3d0m8vnfbdxc7izdyd92-attr-2.5.1
  /nix/store/a7f7xfp9wyghf44yv6l6fv9dfw492hd3-bash-5.2-p15
  /nix/store/7lmanxby1n0lwb4a2wdjgrsqfk5vzxsg-bzip2-1.0.8
  /nix/store/ylq35nr0zs7n54c96wx0vl3spwhcf3z9-bzip2-1.0.8-bin
  /nix/store/whinz9rj5h6h8zxp9bkmfzv7fkzc0cq8-coreutils-9.3
  /nix/store/sfzqh8clr15s9cm5876ff83ax0kfr5vj-diffutils-3.10
  /nix/store/41hwancy55ywhy9j63fia9i1rpy0gpjn-ed-1.19
  /nix/store/6igv1bi4jxxvl22vk9k1fqwpyrx8cif7-file-5.44
  /nix/store/w8k9gfc9rkfvvgv1z2pcvpn57xs0nfvy-findutils-4.9.0
  /nix/store/qzxlwhn71a4yx9gb1dyrr06shik3h6v3-gawk-5.2.2
  /nix/store/wrj1i7vfrw4997dzxsx8ky1z47xmnzp4-gcc-12.3.0-lib
  /nix/store/si7fm4vgklis9960c581frfssp5h6530-gcc-12.3.0-libgcc
  /nix/store/ayg065nw0xi1zsyi8glfh5pn4sfqd8xg-glibc-2.37-8
  /nix/store/qvb7bf22jf0k2f1xygcy44l87aqki03w-gmp-with-cxx-6.2.1
  /nix/store/cd6950p53rlxib6vgwh4vy7r6asd9a87-gnu-config-2023-01-21
  /nix/store/mhw4vhrz163p19afdp52disvb5l16zvs-gnugrep-3.11
  /nix/store/92alb87rz7w6yjak1yj4c2ryhsps34az-gnumake-4.4.1
  /nix/store/yrcf918h3vz3x9b36fnm0kf8snvjff9b-gnused-4.9
  /nix/store/xk6lvr5w3bgxm404x8lkgcka2xx3h40q-gnutar-1.34
  /nix/store/nvydgjdaff1i887x2fk8kygcrbxyfyiy-go-1.20.5
  /nix/store/pvvi5kmz97dnlkg8k5dnmv3kikv7asdl-gzip-1.12
  /nix/store/7l7qrvdlfsx2xwwq2bskrfb7wds9s7y3-iana-etc-20230316
  /nix/store/vh4pdds47783g12fmywazdx3v3kx0j4x-libidn2-2.3.4
  /nix/store/aw137ya6rvy61zw8ydsz22xwarsr8ynf-libunistring-1.1
  /nix/store/7mr6k2mfh18hc90j7zlcw7d83gn1wzfz-libxcrypt-4.4.35
  /nix/store/pv29wwix860q9zcsii88iwfwc4hbizrm-lndir-1.0.4
  /nix/store/8wznfxkfkrmj286wfzkp001rp8m8z3vm-mailcap-2.1.53
  /nix/store/ssqd1aivzbl9gf5k6dwxh530jjwfsh2z-patch-2.7.6
  /nix/store/vfqcpzf6a6dy1iy3f51gwfny0ks7rgld-patchelf-0.15.0
  /nix/store/78dmf1mys98x7zc3cm0d22j7wsdzpw0j-pcre2-10.42
  /nix/store/wmccghnpfng3hmpgks56k62izma8bvhy-perl-5.36.0
  /nix/store/hf5zdjmd5gr5w519vd7driifnlm37rpw-stdenv-linux
  /nix/store/bnpc0xj14ip2zipad05qd3y9bv2lwkzq-tzdata-2023c
  /nix/store/7h0kcmyzb5r4zgck42w63b753wm2g52s-update-autotools-gnu-config-scripts-hook
  /nix/store/6kyaqlxcmfadiiq0mcdj1symv1jsp58w-xgcc-12.3.0-libgcc
  /nix/store/s4208r60vs0y90xwg4wwfv07kfdwax2g-xz-5.4.3
  /nix/store/1ci6fn5jq64iqkcmhgzjxashsg8bm8p5-xz-5.4.3-bin
  /nix/store/mgz7sp9jxnk7c3rn1hvich9n0k2rjr7m-zlib-1.2.13
copying path '/nix/store/cd6950p53rlxib6vgwh4vy7r6asd9a87-gnu-config-2023-01-21' from 'https://cache.nixos.org'...
copying path '/nix/store/si7fm4vgklis9960c581frfssp5h6530-gcc-12.3.0-libgcc' from 'https://cache.nixos.org'...
copying path '/nix/store/7l7qrvdlfsx2xwwq2bskrfb7wds9s7y3-iana-etc-20230316' from 'https://cache.nixos.org'...
copying path '/nix/store/aw137ya6rvy61zw8ydsz22xwarsr8ynf-libunistring-1.1' from 'https://cache.nixos.org'...
copying path '/nix/store/8wznfxkfkrmj286wfzkp001rp8m8z3vm-mailcap-2.1.53' from 'https://cache.nixos.org'...
copying path '/nix/store/vh4pdds47783g12fmywazdx3v3kx0j4x-libidn2-2.3.4' from 'https://cache.nixos.org'...
copying path '/nix/store/bnpc0xj14ip2zipad05qd3y9bv2lwkzq-tzdata-2023c' from 'https://cache.nixos.org'...
copying path '/nix/store/7h0kcmyzb5r4zgck42w63b753wm2g52s-update-autotools-gnu-config-scripts-hook' from 'https://cache.nixos.org'...
copying path '/nix/store/6kyaqlxcmfadiiq0mcdj1symv1jsp58w-xgcc-12.3.0-libgcc' from 'https://cache.nixos.org'...
copying path '/nix/store/ayg065nw0xi1zsyi8glfh5pn4sfqd8xg-glibc-2.37-8' from 'https://cache.nixos.org'...
copying path '/nix/store/65jnw3qlvhpk3d0m8vnfbdxc7izdyd92-attr-2.5.1' from 'https://cache.nixos.org'...
copying path '/nix/store/a7f7xfp9wyghf44yv6l6fv9dfw492hd3-bash-5.2-p15' from 'https://cache.nixos.org'...
copying path '/nix/store/2jdmi86cvcrjrgmjc9mx119zbq278ssi-acl-2.3.1' from 'https://cache.nixos.org'...
copying path '/nix/store/7lmanxby1n0lwb4a2wdjgrsqfk5vzxsg-bzip2-1.0.8' from 'https://cache.nixos.org'...
copying path '/nix/store/41hwancy55ywhy9j63fia9i1rpy0gpjn-ed-1.19' from 'https://cache.nixos.org'...
copying path '/nix/store/ylq35nr0zs7n54c96wx0vl3spwhcf3z9-bzip2-1.0.8-bin' from 'https://cache.nixos.org'...
copying path '/nix/store/qzxlwhn71a4yx9gb1dyrr06shik3h6v3-gawk-5.2.2' from 'https://cache.nixos.org'...
copying path '/nix/store/wrj1i7vfrw4997dzxsx8ky1z47xmnzp4-gcc-12.3.0-lib' from 'https://cache.nixos.org'...
copying path '/nix/store/92alb87rz7w6yjak1yj4c2ryhsps34az-gnumake-4.4.1' from 'https://cache.nixos.org'...
copying path '/nix/store/qvb7bf22jf0k2f1xygcy44l87aqki03w-gmp-with-cxx-6.2.1' from 'https://cache.nixos.org'...
copying path '/nix/store/yrcf918h3vz3x9b36fnm0kf8snvjff9b-gnused-4.9' from 'https://cache.nixos.org'...
copying path '/nix/store/whinz9rj5h6h8zxp9bkmfzv7fkzc0cq8-coreutils-9.3' from 'https://cache.nixos.org'...
copying path '/nix/store/xk6lvr5w3bgxm404x8lkgcka2xx3h40q-gnutar-1.34' from 'https://cache.nixos.org'...
copying path '/nix/store/sfzqh8clr15s9cm5876ff83ax0kfr5vj-diffutils-3.10' from 'https://cache.nixos.org'...
copying path '/nix/store/w8k9gfc9rkfvvgv1z2pcvpn57xs0nfvy-findutils-4.9.0' from 'https://cache.nixos.org'...
copying path '/nix/store/nvydgjdaff1i887x2fk8kygcrbxyfyiy-go-1.20.5' from 'https://cache.nixos.org'...
copying path '/nix/store/pvvi5kmz97dnlkg8k5dnmv3kikv7asdl-gzip-1.12' from 'https://cache.nixos.org'...
copying path '/nix/store/7mr6k2mfh18hc90j7zlcw7d83gn1wzfz-libxcrypt-4.4.35' from 'https://cache.nixos.org'...
copying path '/nix/store/pv29wwix860q9zcsii88iwfwc4hbizrm-lndir-1.0.4' from 'https://cache.nixos.org'...
copying path '/nix/store/ssqd1aivzbl9gf5k6dwxh530jjwfsh2z-patch-2.7.6' from 'https://cache.nixos.org'...
copying path '/nix/store/vfqcpzf6a6dy1iy3f51gwfny0ks7rgld-patchelf-0.15.0' from 'https://cache.nixos.org'...
copying path '/nix/store/78dmf1mys98x7zc3cm0d22j7wsdzpw0j-pcre2-10.42' from 'https://cache.nixos.org'...
copying path '/nix/store/s4208r60vs0y90xwg4wwfv07kfdwax2g-xz-5.4.3' from 'https://cache.nixos.org'...
copying path '/nix/store/mhw4vhrz163p19afdp52disvb5l16zvs-gnugrep-3.11' from 'https://cache.nixos.org'...
copying path '/nix/store/1ci6fn5jq64iqkcmhgzjxashsg8bm8p5-xz-5.4.3-bin' from 'https://cache.nixos.org'...
copying path '/nix/store/mgz7sp9jxnk7c3rn1hvich9n0k2rjr7m-zlib-1.2.13' from 'https://cache.nixos.org'...
copying path '/nix/store/6igv1bi4jxxvl22vk9k1fqwpyrx8cif7-file-5.44' from 'https://cache.nixos.org'...
copying path '/nix/store/wmccghnpfng3hmpgks56k62izma8bvhy-perl-5.36.0' from 'https://cache.nixos.org'...
copying path '/nix/store/hf5zdjmd5gr5w519vd7driifnlm37rpw-stdenv-linux' from 'https://cache.nixos.org'...
building '/nix/store/ncjc9ppbkah02375xzh0hxl73yxr5pj7-bazel-go-toolchain-go-version.drv'...
building '/nix/store/hh0ss11kiini8ajm0l5l11r9l6lbqdar-builder.pl.drv'...
building '/nix/store/yyr5a7zxj30mgxrwiqa3z0n1la7nn742-bazel-go-toolchain.drv'...
created 2 symlinks in user environment
building '/nix/store/35q12y2aq3ph8sh40j5fqfdd9wll9kf1-bazel-go-toolchain.drv'...
/nix/store/qjynhwar1pjwgi4dfkc069a8jjbihmwr-bazel-go-toolchain
INFO: Repository sdk_go_nix instantiated at:
  /build/0hc0kj34zdpgmlnn23wbhywlmh37p124-source/WORKSPACE:51:21: in <toplevel>
  /build/output/external/rules_nixpkgs_go/go.bzl:398:20: in nixpkgs_go_configure
  /build/output/external/rules_nixpkgs_core/nixpkgs.bzl:676:21: in nixpkgs_package
Repository rule _nixpkgs_package defined at:
  /build/output/external/rules_nixpkgs_core/nixpkgs.bzl:549:35: in <toplevel>
Analyzing: target //cmd/nixbazelgotemplate:nixbazelgotemplate (45 packages loaded, 260 targets configured)
ERROR: An error occurred during the fetch of repository 'sdk_go_nix':
   Traceback (most recent call last):
	File "/build/output/external/rules_nixpkgs_core/nixpkgs.bzl", line 547, column 31, in _nixpkgs_package_impl
		_nixpkgs_build_and_symlink(repository_ctx, nix_build, build_file_content)
	File "/build/output/external/rules_nixpkgs_core/nixpkgs.bzl", line 417, column 20, in _nixpkgs_build_and_symlink
		execute_or_fail(
	File "/build/output/external/rules_nixpkgs_core/util.bzl", line 97, column 13, in execute_or_fail
		fail("""
Error in fail: 
  Package '@sdk_go_nix' outputs a single file which is not supported by rules_nixpkgs. Please only use directories.
    Command: "/nix/store/whinz9rj5h6h8zxp9bkmfzv7fkzc0cq8-coreutils-9.3/bin/test" "-d" "/nix/store/qjynhwar1pjwgi4dfkc069a8jjbihmwr-bazel-go-toolchain"
    Return code: 1
    Error output: 

ERROR: /build/0hc0kj34zdpgmlnn23wbhywlmh37p124-source/WORKSPACE:51:21: fetching _nixpkgs_package rule //external:sdk_go_nix: Traceback (most recent call last):
	File "/build/output/external/rules_nixpkgs_core/nixpkgs.bzl", line 547, column 31, in _nixpkgs_package_impl
		_nixpkgs_build_and_symlink(repository_ctx, nix_build, build_file_content)
	File "/build/output/external/rules_nixpkgs_core/nixpkgs.bzl", line 417, column 20, in _nixpkgs_build_and_symlink
		execute_or_fail(
	File "/build/output/external/rules_nixpkgs_core/util.bzl", line 97, column 13, in execute_or_fail
		fail("""
Error in fail: 
  Package '@sdk_go_nix' outputs a single file which is not supported by rules_nixpkgs. Please only use directories.
    Command: "/nix/store/whinz9rj5h6h8zxp9bkmfzv7fkzc0cq8-coreutils-9.3/bin/test" "-d" "/nix/store/qjynhwar1pjwgi4dfkc069a8jjbihmwr-bazel-go-toolchain"
    Return code: 1
    Error output: 

ERROR: /build/output/external/sdk_go_nix_toolchains/BUILD.bazel:4:19: @sdk_go_nix_toolchains//:toolchain_go_linux_amd64-impl depends on @sdk_go_nix//:builder in repository @sdk_go_nix which failed to fetch. no such package '@sdk_go_nix//': 
  Package '@sdk_go_nix' outputs a single file which is not supported by rules_nixpkgs. Please only use directories.
    Command: "/nix/store/whinz9rj5h6h8zxp9bkmfzv7fkzc0cq8-coreutils-9.3/bin/test" "-d" "/nix/store/qjynhwar1pjwgi4dfkc069a8jjbihmwr-bazel-go-toolchain"
    Return code: 1
    Error output: 

ERROR: [0m/build/output/external/sdk_go_nix_toolchains/BUILD.bazel:4:19: @sdk_go_nix_toolchains//:toolchain_go_linux_amd64-impl depends on @sdk_go_nix//:go_sdk in repository @sdk_go_nix which failed to fetch. no such package '@sdk_go_nix//': 
  Package '@sdk_go_nix' outputs a single file which is not supported by rules_nixpkgs. Please only use directories.
    Command: "/nix/store/whinz9rj5h6h8zxp9bkmfzv7fkzc0cq8-coreutils-9.3/bin/test" "-d" "/nix/store/qjynhwar1pjwgi4dfkc069a8jjbihmwr-bazel-go-toolchain"
    Return code: 1
    Error output: 

ERROR: Analysis of target '//cmd/nixbazelgotemplate:nixbazelgotemplate' failed; build aborted: 
INFO: Elapsed time: 45.452s
INFO: 0 processes.
FAILED: Build did NOT complete successfully (45 packages loaded, 260 targets configured)
```
