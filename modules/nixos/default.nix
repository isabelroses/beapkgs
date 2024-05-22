_: {
  default = builtins.throw "No default module is provided";
  wakapi = import ./wakapi.nix { };
}
