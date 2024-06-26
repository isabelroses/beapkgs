self: {
  imports = [
    (import ./bellado.nix self)
    (import ./izrss.nix self)
  ];
}
