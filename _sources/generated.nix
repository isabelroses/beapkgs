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
    version = "3cbacecb6404ca127d1f0ca64dbf8a9760467359";
    src = fetchFromGitHub {
      owner = "isabelroses";
      repo = "blahaj";
      rev = "3cbacecb6404ca127d1f0ca64dbf8a9760467359";
      fetchSubmodules = false;
      sha256 = "sha256-jJKsdTbYlsOFgx9agJyyvZ+7xiy/5Ly4Aq5PrGdDzlU=";
    };
    date = "2024-07-09";
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
    version = "v0.0.18";
    src = fetchFromGitHub {
      owner = "mrjosh";
      repo = "helm-ls";
      rev = "v0.0.18";
      fetchSubmodules = false;
      sha256 = "sha256-nOb7hoUOQfmpCYqui+hw5hcL/pURvsMXlksa8KUBjSY=";
    };
  };
  isabelroses-website = {
    pname = "isabelroses-website";
    version = "aea556c282b8d2216126ad859e5620f15e7984a6";
    src = fetchFromGitHub {
      owner = "isabelroses";
      repo = "website";
      rev = "aea556c282b8d2216126ad859e5620f15e7984a6";
      fetchSubmodules = false;
      sha256 = "sha256-e03MZEr+3WC4LQzR/MDGwFTEFNKA7EVfkAnU0PGcs3U=";
    };
    date = "2024-07-13";
  };
  ito = {
    pname = "ito";
    version = "30596468c71e1da2176eea78206486c60559bab6";
    src = fetchFromGitHub {
      owner = "uncenter";
      repo = "ito";
      rev = "30596468c71e1da2176eea78206486c60559bab6";
      fetchSubmodules = false;
      sha256 = "sha256-g8hPXX91+TKijEMqDhhSeHSAYBYIkwnRnLff/yGhOWs=";
    };
    date = "2024-07-09";
  };
  izrss = {
    pname = "izrss";
    version = "7d6e5f67f0fdc4ee2e07ed7259338487db6fd74b";
    src = fetchFromGitHub {
      owner = "isabelroses";
      repo = "izrss";
      rev = "7d6e5f67f0fdc4ee2e07ed7259338487db6fd74b";
      fetchSubmodules = false;
      sha256 = "sha256-IIYV0P34tQ8L5U0yt1AwbDFivW7c7jZbRnqicsdvV2M=";
    };
    date = "2024-07-02";
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
  nh-darwin = {
    pname = "nh-darwin";
    version = "aa4bc963cbbdc44d0ed35d18345c911d465a5c7e";
    src = fetchFromGitHub {
      owner = "ToyVo";
      repo = "nh_darwin";
      rev = "aa4bc963cbbdc44d0ed35d18345c911d465a5c7e";
      fetchSubmodules = false;
      sha256 = "sha256-yX0NOCmiRq3iMAwsKoSMxhfBMkLlZirHdmAyZIL95FM=";
    };
    date = "2024-07-02";
  };
  nixpkgs-using = {
    pname = "nixpkgs-using";
    version = "c716afae7bb1ded4ea5b6283d5778b88f6e75482";
    src = fetchFromGitHub {
      owner = "uncenter";
      repo = "nixpkgs-using";
      rev = "c716afae7bb1ded4ea5b6283d5778b88f6e75482";
      fetchSubmodules = false;
      sha256 = "sha256-XAC3Ejf/ZMJr1h/4BTmlOKALhZdLEVdMQE6qEEjRZSE=";
    };
    date = "2024-07-09";
  };
  purr = {
    pname = "purr";
    version = "4713916157d515ae824140a5d3a5cfc3dfc8d37e";
    src = fetchFromGitHub {
      owner = "uncenter";
      repo = "purr";
      rev = "4713916157d515ae824140a5d3a5cfc3dfc8d37e";
      fetchSubmodules = false;
      sha256 = "sha256-D6P4tg3eb0d/S0/aINszE6iV/oYJ9KihWYux43iNy58=";
    };
    date = "2024-07-09";
  };
  ringfairy = {
    pname = "ringfairy";
    version = "2e8936af16428efae5123489d6d4b2504a3c11b3";
    src = fetchFromGitHub {
      owner = "k3rs3d";
      repo = "ringfairy";
      rev = "2e8936af16428efae5123489d6d4b2504a3c11b3";
      fetchSubmodules = false;
      sha256 = "sha256-4DWQCyVtqMKKgBAOejve9v/en1tfFi6FN3eeuC7B5I0=";
    };
    date = "2024-06-29";
  };
  wezterm = {
    pname = "wezterm";
    version = "c9116830c27baf0c547a1524d33363fd5e42295a";
    src = fetchFromGitHub {
      owner = "wez";
      repo = "wezterm";
      rev = "c9116830c27baf0c547a1524d33363fd5e42295a";
      fetchSubmodules = true;
      sha256 = "sha256-TUQVcrR9QUBWkhxoKz23a12ZvAPcG3PcNGZRC4q9kNc=";
    };
    cargoLock."Cargo.lock" = {
      lockFile = ./wezterm-c9116830c27baf0c547a1524d33363fd5e42295a/Cargo.lock;
      outputHashes = {
        "xcb-imdkit-0.3.0" = "sha256-77KaJO+QJWy3tJ9AF1TXKaQHpoVOfGIRqteyqpQaSWo=";
        "sqlite-cache-0.1.3" = "sha256-sBAC8MsQZgH+dcWpoxzq9iw5078vwzCijgyQnMOWIkk=";
      };
    };
    date = "2024-07-15";
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
