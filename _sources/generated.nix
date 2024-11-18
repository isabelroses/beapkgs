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
    version = "1fb64b805dd15744919649b5ca9dc5e678492e5f";
    src = fetchFromGitHub {
      owner = "isabelroses";
      repo = "blahaj";
      rev = "1fb64b805dd15744919649b5ca9dc5e678492e5f";
      fetchSubmodules = false;
      sha256 = "sha256-RdNeRmONn3LbYQ0mwCwAWOJx+F43+/agjRjIpLmdfiA=";
    };
    cargoLock."Cargo.lock" = {
      lockFile = ./blahaj-1fb64b805dd15744919649b5ca9dc5e678492e5f/Cargo.lock;
      outputHashes = {
        "git-tracker-0.2.0" = "sha256-ZOD/8Wjn7lNZjpiOLBwmYCcEe8tYmxxDMhhiWJViGws=";
      };
    };
    date = "2024-10-13";
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
  hael = {
    pname = "hael";
    version = "d604e456f3f1b1c5df011204adb74d7e27a1fce5";
    src = fetchFromGitHub {
      owner = "isabelroses";
      repo = "hael";
      rev = "d604e456f3f1b1c5df011204adb74d7e27a1fce5";
      fetchSubmodules = false;
      sha256 = "sha256-QtOkCIReOgSRz/hMWT3v1PSpS0Dv8TgKkVnZv8AjsIE=";
    };
    date = "2024-03-25";
  };
  helm-ls = {
    pname = "helm-ls";
    version = "v0.1.0";
    src = fetchFromGitHub {
      owner = "mrjosh";
      repo = "helm-ls";
      rev = "v0.1.0";
      fetchSubmodules = false;
      sha256 = "sha256-EuZbbeRssacrctIbxBbd2GOh8zgFi2OBRregfC88se0=";
    };
  };
  hyfetch = {
    pname = "hyfetch";
    version = "1b3b5ca883cdff47017d1be636a735162e19b6e8";
    src = fetchFromGitHub {
      owner = "hykilpikonna";
      repo = "hyfetch";
      rev = "1b3b5ca883cdff47017d1be636a735162e19b6e8";
      fetchSubmodules = false;
      sha256 = "sha256-qK7loxQXAklR8psMVugZReFYh2FbzrS3nLTZRV0Z+Ro=";
    };
    cargoLock."Cargo.lock" = {
      lockFile = ./hyfetch-1b3b5ca883cdff47017d1be636a735162e19b6e8/Cargo.lock;
      outputHashes = {
        
      };
    };
    date = "2024-11-11";
  };
  isabelroses-website = {
    pname = "isabelroses-website";
    version = "20de3520c58c42d8d435e755a79a8eb077a2e1ff";
    src = fetchFromGitHub {
      owner = "isabelroses";
      repo = "website";
      rev = "20de3520c58c42d8d435e755a79a8eb077a2e1ff";
      fetchSubmodules = false;
      sha256 = "sha256-/PApKnetermcVz9K3RaoddJ5ldQWZd9k6clpkF8TjfQ=";
    };
    cargoLock."Cargo.lock" = {
      lockFile = ./isabelroses-website-20de3520c58c42d8d435e755a79a8eb077a2e1ff/Cargo.lock;
      outputHashes = {
        
      };
    };
    date = "2024-11-17";
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
    cargoLock."Cargo.lock" = {
      lockFile = ./ito-30596468c71e1da2176eea78206486c60559bab6/Cargo.lock;
      outputHashes = {
        
      };
    };
    date = "2024-07-09";
  };
  izrss = {
    pname = "izrss";
    version = "47460bfdfde0ec797daa52150fff6106819b7d0a";
    src = fetchFromGitHub {
      owner = "isabelroses";
      repo = "izrss";
      rev = "47460bfdfde0ec797daa52150fff6106819b7d0a";
      fetchSubmodules = false;
      sha256 = "sha256-UcE/zzGjBVst6+tE/Znary7pvQIAELj6eB7T2m803BM=";
    };
    date = "2024-08-22";
  };
  jq-lsp = {
    pname = "jq-lsp";
    version = "92763427b397246344db1bf9c7cd66339f351bc1";
    src = fetchFromGitHub {
      owner = "wader";
      repo = "jq-lsp";
      rev = "92763427b397246344db1bf9c7cd66339f351bc1";
      fetchSubmodules = false;
      sha256 = "sha256-oe3yTcI5sMdWPV7rZF6VbQvtigKQliWYtiU7a47ipHY=";
    };
    date = "2024-11-08";
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
    cargoLock."Cargo.lock" = {
      lockFile = ./meower-edc08e7f0f22041d28c70bccd9fd6100e31c1040/Cargo.lock;
      outputHashes = {
        
      };
    };
    date = "2024-06-15";
  };
  nh-darwin = {
    pname = "nh-darwin";
    version = "f19fcb3ad4c2f0686c36243fd8a9f7793942dea2";
    src = fetchFromGitHub {
      owner = "ToyVo";
      repo = "nh_darwin";
      rev = "f19fcb3ad4c2f0686c36243fd8a9f7793942dea2";
      fetchSubmodules = false;
      sha256 = "sha256-u6rTrvXRii4wm1qs1F0/IcRDLwfEcEDxC5YO5NkL8Gg=";
    };
    cargoLock."Cargo.lock" = {
      lockFile = ./nh-darwin-f19fcb3ad4c2f0686c36243fd8a9f7793942dea2/Cargo.lock;
      outputHashes = {
        
      };
    };
    date = "2024-11-17";
  };
  nixpkgs-track = {
    pname = "nixpkgs-track";
    version = "4792e406455f7dda87ee5915fdaaeaa9b44569fd";
    src = fetchFromGitHub {
      owner = "uncenter";
      repo = "nixpkgs-track";
      rev = "4792e406455f7dda87ee5915fdaaeaa9b44569fd";
      fetchSubmodules = false;
      sha256 = "sha256-KnCrng2k2yGxxakA9OsFBeKozE4CXo3TaqG4/wqqaj8=";
    };
    cargoLock."Cargo.lock" = {
      lockFile = ./nixpkgs-track-4792e406455f7dda87ee5915fdaaeaa9b44569fd/Cargo.lock;
      outputHashes = {
        
      };
    };
    date = "2024-10-10";
  };
  nixpkgs-using = {
    pname = "nixpkgs-using";
    version = "9824a8023dec1f183df66a3dff2c7fe9d41cb498";
    src = fetchFromGitHub {
      owner = "uncenter";
      repo = "nixpkgs-using";
      rev = "9824a8023dec1f183df66a3dff2c7fe9d41cb498";
      fetchSubmodules = false;
      sha256 = "sha256-5bblEPHbLenricLHZYZw1OyXxoEZNlYgt/JCgnE6tas=";
    };
    cargoLock."Cargo.lock" = {
      lockFile = ./nixpkgs-using-9824a8023dec1f183df66a3dff2c7fe9d41cb498/Cargo.lock;
      outputHashes = {
        
      };
    };
    date = "2024-10-31";
  };
  purr = {
    pname = "purr";
    version = "e03d3075b4b1ee19148a4902332ffe29dbb39bea";
    src = fetchFromGitHub {
      owner = "uncenter";
      repo = "purr";
      rev = "e03d3075b4b1ee19148a4902332ffe29dbb39bea";
      fetchSubmodules = false;
      sha256 = "sha256-a5jtJp0r/8iL+E8JhkgdVyKqYQc+uoXpRjf48N1CQ10=";
    };
    cargoLock."Cargo.lock" = {
      lockFile = ./purr-e03d3075b4b1ee19148a4902332ffe29dbb39bea/Cargo.lock;
      outputHashes = {
        
      };
    };
    date = "2024-11-12";
  };
  ringfairy = {
    pname = "ringfairy";
    version = "8635cb208f854fc5545b59db1cb602bf2f10e25a";
    src = fetchFromGitHub {
      owner = "k3rs3d";
      repo = "ringfairy";
      rev = "8635cb208f854fc5545b59db1cb602bf2f10e25a";
      fetchSubmodules = false;
      sha256 = "sha256-0xN9Ddg/Vg9isJGPKgoSCf3fbTCB1PXSoowrroTHDtY=";
    };
    cargoLock."Cargo.lock" = {
      lockFile = ./ringfairy-8635cb208f854fc5545b59db1cb602bf2f10e25a/Cargo.lock;
      outputHashes = {
        
      };
    };
    date = "2024-09-06";
  };
  wezterm = {
    pname = "wezterm";
    version = "979df7826965348345a3305ed889a4b9aef838e1";
    src = fetchFromGitHub {
      owner = "wez";
      repo = "wezterm";
      rev = "979df7826965348345a3305ed889a4b9aef838e1";
      fetchSubmodules = true;
      sha256 = "sha256-DJhA2T94KtG+Fj7DACTsM5XyZAl58GfN4q1btUjKw9E=";
    };
    cargoLock."Cargo.lock" = {
      lockFile = ./wezterm-979df7826965348345a3305ed889a4b9aef838e1/Cargo.lock;
      outputHashes = {
        "xcb-imdkit-0.3.0" = "sha256-77KaJO+QJWy3tJ9AF1TXKaQHpoVOfGIRqteyqpQaSWo=";
        "sqlite-cache-0.1.3" = "sha256-sBAC8MsQZgH+dcWpoxzq9iw5078vwzCijgyQnMOWIkk=";
      };
    };
    date = "2024-11-14";
  };
  zzz = {
    pname = "zzz";
    version = "0e925cee1e869c80f678d3b5ca81d930bffdfc9a";
    src = fetchFromGitHub {
      owner = "isabelroses";
      repo = "zzz";
      rev = "0e925cee1e869c80f678d3b5ca81d930bffdfc9a";
      fetchSubmodules = false;
      sha256 = "sha256-H6I4r6pzezkV7L9zbbr3lUGX1azmijZinN+Oc/0O0eQ=";
    };
    date = "2024-08-09";
  };
}
