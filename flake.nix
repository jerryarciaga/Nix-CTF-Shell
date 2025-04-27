{
  description = "A CTF Nix shell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      config.allowUnsupportedSystem = true;
    };
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        # Essentials
        openvpn
        docker
        unzip
        file
        steam-run

        # Network tools
        nmap
        netcat-gnu
        wireshark
        burpsuite
        gobuster

        # Binaries / Debuggers / Reverse Engineering Tools
        nix-ld
        strace
        ltrace
        hexedit
        gdb
        radare2
        ghidra
        binwalk
        fastjar
        
        # Exploits
        metasploit

        # Steganography / Image hacks
        exiftool
        steghide
        zsteg
        pngcheck

        # Programming/Scripting
        nasm
        (python3.withPackages (python-pkgs: with python-pkgs; [
          pwntools
          requests
          numpy
          z3-solver
          pycrypto
        ]))
      ];

      shellHook = ''
        alias rot13="tr 'A-Za-z' 'N-ZA-Mn-za-m'"

        echo "It's hacking time!"
        export PS1="\[\033[1;32m\][\[\e]0;\u@\h: \
          \w\a\]hacker@\h:\w]\$\[\033[0m\] "
      '';
    };
  };
}
