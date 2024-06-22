# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  bellado = {
    pname = "bellado";
    version = "8b9bb4e19b06a35acd8b2d39830c2751246ff189";
    src = fetchFromGitHub {
      owner = "isabelroses";
      repo = "bellado";
      rev = "8b9bb4e19b06a35acd8b2d39830c2751246ff189";
      fetchSubmodules = false;
      sha256 = "sha256-evko1/qE4oRXTMdCOGuwJRUkRm7Sxb5MhQCTLgx5Z+4=";
    };
    date = "2023-12-16";
  };
  blahaj = {
    pname = "blahaj";
    version = "627b93ddc1f765f8aa22e73da54eca79ee713649";
    src = fetchFromGitHub {
      owner = "isabelroses";
      repo = "blahaj";
      rev = "627b93ddc1f765f8aa22e73da54eca79ee713649";
      fetchSubmodules = false;
      sha256 = "sha256-eQGRilraJf2P+Eqt2AX15pVh+X4BLrjo5Y3gq96FWlQ=";
    };
    date = "2024-06-19";
  };
  catppuccin-gtk = {
    pname = "catppuccin-gtk";
    version = "23b52b5b9cde1e11c07315e79a55804d2ac77e3a";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "gtk";
      rev = "23b52b5b9cde1e11c07315e79a55804d2ac77e3a";
      fetchSubmodules = false;
      sha256 = "sha256-4tBGN+Rra6C2pjkoLWmNqaYUwpzALsYrn4tkYGUtQl4=";
    };
    date = "2024-06-02";
  };
  colloid-gtk-theme = {
    pname = "colloid-gtk-theme";
    version = "dfff1a7817d8bf3ba403cc2335a86064c165136a";
    src = fetchFromGitHub {
      owner = "vinceliuice";
      repo = "Colloid-gtk-theme";
      rev = "dfff1a7817d8bf3ba403cc2335a86064c165136a";
      fetchSubmodules = false;
      sha256 = "sha256-UhR2htAnulgQLhVd/Se15S6wqXqvLQq8k95fjrbyN+M=";
    };
    date = "2024-06-22";
  };
  go-enum = {
    pname = "go-enum";
    version = "v0.6.0";
    src = fetchFromGitHub {
      owner = "abice";
      repo = "go-enum";
      rev = "v0.6.0";
      fetchSubmodules = false;
      sha256 = "sha256-Mt45Qz8l++bvBLKEpbX0m8iTkHDpsZtdYhhHUprQKY8=";
    };
  };
  gomvp = {
    pname = "gomvp";
    version = "5b06c041c898822fd72cd245188e51d112adae74";
    src = fetchFromGitHub {
      owner = "abenz1267";
      repo = "gomvp";
      rev = "5b06c041c898822fd72cd245188e51d112adae74";
      fetchSubmodules = false;
      sha256 = "sha256-dXjI+nItJCAGKxyC9tX11hxWHCP+NgXtTYtm5+6dqDU=";
    };
    date = "2022-10-25";
  };
  helm-ls = {
    pname = "helm-ls";
    version = "v0.0.17";
    src = fetchFromGitHub {
      owner = "mrjosh";
      repo = "helm-ls";
      rev = "v0.0.17";
      fetchSubmodules = false;
      sha256 = "sha256-c72QFlsCPBW4biTMh1nxQIEkKPjmSmxOD93Kzduswyo=";
    };
  };
  isabelroses-website = {
    pname = "isabelroses-website";
    version = "8ae059c8c6438b6e47bbc1e8b4fa13facf924dd1";
    src = fetchFromGitHub {
      owner = "isabelroses";
      repo = "website";
      rev = "8ae059c8c6438b6e47bbc1e8b4fa13facf924dd1";
      fetchSubmodules = false;
      sha256 = "sha256-qLRcIgzz2AmzNVShG587NryWcXC8/1yewg1f0Hkj+uA=";
    };
    date = "2024-06-22";
  };
  ito = {
    pname = "ito";
    version = "7dfbb2ab5fff469ff7e74b6c03e85afb786d14be";
    src = fetchFromGitHub {
      owner = "uncenter";
      repo = "ito";
      rev = "7dfbb2ab5fff469ff7e74b6c03e85afb786d14be";
      fetchSubmodules = false;
      sha256 = "sha256-k3QCAgtQ5LeXE6a2N3oDIOvGqInBEQTotsdGbbYR2+0=";
    };
    date = "2024-06-10";
  };
  izrss = {
    pname = "izrss";
    version = "eb3f319fdd0493ddcfba3f0d4b5514c9a3f961e9";
    src = fetchFromGitHub {
      owner = "isabelroses";
      repo = "izrss";
      rev = "eb3f319fdd0493ddcfba3f0d4b5514c9a3f961e9";
      fetchSubmodules = false;
      sha256 = "sha256-SuqVnieTlnTODPshj+fVHz8fLvCIwZnIfKgXCFiEUVA=";
    };
    date = "2024-06-19";
  };
  jq-lsp = {
    pname = "jq-lsp";
    version = "01e96e9809ef775783cefb41a564d78162cece0f";
    src = fetchFromGitHub {
      owner = "wader";
      repo = "jq-lsp";
      rev = "01e96e9809ef775783cefb41a564d78162cece0f";
      fetchSubmodules = false;
      sha256 = "sha256-c7uK8WPM/h2PLVLFGeN66SztvzjBCgJje7L14+oErVU=";
    };
    date = "2024-04-02";
  };
  json-to-struct = {
    pname = "json-to-struct";
    version = "1f65fffbfdbb2b0e56a3f6f6cd24daad58e90dec";
    src = fetchFromGitHub {
      owner = "tmc";
      repo = "json-to-struct";
      rev = "1f65fffbfdbb2b0e56a3f6f6cd24daad58e90dec";
      fetchSubmodules = false;
      sha256 = "sha256-l/XLZstZFVnYXRqtng1oiCSvhNAomyeTuI1OtCb8UHo=";
    };
    date = "2023-06-13";
  };
  meower = {
    pname = "meower";
    version = "edc08e7f0f22041d28c70bccd9fd6100e31c1040";
    src = fetchFromGitHub {
      owner = "Noxyntious";
      repo = "meower";
      rev = "edc08e7f0f22041d28c70bccd9fd6100e31c1040";
      fetchSubmodules = false;
      sha256 = "sha256-aM69CmZYVRuhuUnAsjojraiv9VXTvhJxIPohw50Qpv8=";
    };
    date = "2024-06-15";
  };
  nixpkgs-using = {
    pname = "nixpkgs-using";
    version = "d07d099be6816aea21e52f89eac102aee2347906";
    src = fetchFromGitHub {
      owner = "uncenter";
      repo = "nixpkgs-using";
      rev = "d07d099be6816aea21e52f89eac102aee2347906";
      fetchSubmodules = false;
      sha256 = "sha256-VQNefwVa1zHL1TLrO5s4xj6k2fNFVM6J8PIYpCR40T4=";
    };
    date = "2024-06-10";
  };
  purr = {
    pname = "purr";
    version = "0338a6eb1ab329ed8a1a8970600f8ffdd13a59a5";
    src = fetchFromGitHub {
      owner = "uncenter";
      repo = "purr";
      rev = "0338a6eb1ab329ed8a1a8970600f8ffdd13a59a5";
      fetchSubmodules = false;
      sha256 = "sha256-AVfdk7+wuZ3dwV25EK5fbU4fwjBcgF6ewU3C6Sn8DCU=";
    };
    date = "2024-06-19";
  };
  ringfairy = {
    pname = "ringfairy";
    version = "bce9dce450d9fa8406f12f64045ca21f9f548942";
    src = fetchFromGitHub {
      owner = "k3rs3d";
      repo = "ringfairy";
      rev = "bce9dce450d9fa8406f12f64045ca21f9f548942";
      fetchSubmodules = false;
      sha256 = "sha256-dyqmjjhX3aehxoziV1C8Xsh/tNR2mhMBgcziPPNqqkA=";
    };
    date = "2024-06-02";
  };
  wezterm = {
    pname = "wezterm";
    version = "cb1406860a23896ca6935696169644d140e29208";
    src = fetchFromGitHub {
      owner = "wez";
      repo = "wezterm";
      rev = "cb1406860a23896ca6935696169644d140e29208";
      fetchSubmodules = true;
      sha256 = "sha256-5BsbCoK6JYcDKlnzVEvB+ivNt51rYDySUoYb4L9bYFc=";
    };
    cargoLock."Cargo.lock" = {
      lockFile = ./wezterm-cb1406860a23896ca6935696169644d140e29208/Cargo.lock;
      outputHashes = {
        "xcb-imdkit-0.3.0" = "sha256-77KaJO+QJWy3tJ9AF1TXKaQHpoVOfGIRqteyqpQaSWo=";
        "sqlite-cache-0.1.3" = "sha256-sBAC8MsQZgH+dcWpoxzq9iw5078vwzCijgyQnMOWIkk=";
      };
    };
    date = "2024-06-17";
  };
  zzz = {
    pname = "zzz";
    version = "3429b1f17c6cb755697e0520d98a223789b7c8c1";
    src = fetchFromGitHub {
      owner = "isabelroses";
      repo = "zzz";
      rev = "3429b1f17c6cb755697e0520d98a223789b7c8c1";
      fetchSubmodules = false;
      sha256 = "sha256-nogVarYxWoSpDQtk1AQnyOrYFGDwjeN/2ybv5aSGwM4=";
    };
    date = "2024-05-30";
  };
}
