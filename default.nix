{ stdenv, buildGoModule, self }:

let
  versionPath = "${self.inputs.tektoncli}/VERSION";
  version =
    if builtins.pathExists versionPath then
      builtins.replaceStrings
        [ "\n" "\r" "\t" ] [ "" "" "" ]
        (builtins.readFile versionPath)
    else self.inputs.tektoncli.rev;
in
buildGoModule {
  pname = "tektoncli";
  inherit version;
  src = self.inputs.tektoncli;
  vendorSha256 = null;
  CGO_ENABLED = 0;
  buildFlagsArray = [ "-ldflags=-X github.com/tektoncd/cli/pkg/cmd/version.clientVersion=${version}" ];
  doCheck = false;
  subPackages = [ "cmd/tkn" ];
  meta = {
    description = "A CLI for interacting with Tekton.";
    homepage = "https://github.com/tektoncd/cli";
    license = stdenv.lib.licenses.asl20;
    maintainers = [
      {
        email = "john@insane.se";
        github = "johnae";
        name = "John Axel Eriksson";
      }
    ];
  };
}
