{ stdenv, buildGoModule, self }:

buildGoModule {
  pname = "tektoncli";
  version = self.inputs.tektoncli.rev;
  src = self.inputs.tektoncli;
  #vendorSha256 = "sha256-iWA1b5RAYDxoDCg8ClhWUIpG7Zr6WSbkblq4DDvCf+J=";
  vendorSha256 = null;
  CGO_ENABLED = 0;
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
