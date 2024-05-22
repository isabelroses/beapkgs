{ self, ... }:
{
  bellado = import ./bellado.nix self;
  izrss = import ./izrss.nix self;
}
