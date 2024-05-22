{ self, ... }:
{
  default = builtins.throw "No default module is provided";

  bellado = import ./bellado.nix self;
  izrss = import ./izrss.nix self;
}
