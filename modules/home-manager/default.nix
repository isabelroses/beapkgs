self: {
  imports = [
    (import ./bellado.nix self)
    (import ./izrss.nix self)
    (import ./zzz.nix self)
  ];
}
