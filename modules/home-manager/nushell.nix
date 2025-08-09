{ ... }:
{
  programs.nushell = {
    enable = true;
    extraConfig = ''
      # remove banner
      $env.config.show_banner = false

      # alias: nix run nixpkgs#<package> -- <options>
      # to: nixrun <package> <options>
      def --wrapped nixrun [c, ...rest] {
          (nix run $"nixpkgs#($c)" "--" ...$rest)
      }

      # alias: nix shell nixpkgs#<package> -- <options>
      # to: nixshell <package> <options>
      def --wrapped nixshell [c, ...rest] {
          (nix shell $"nixpkgs#($c)" "--" ...$rest)
      }

      # alias: $env.NIXPKGS_ALLOW_UNFREE = 1; nix run --impure nixpkgs#<package> -- <options>
      # to: nixrun-unfree <package> <options>
      def --wrapped nixrun-unfree [c, ...rest] {
          ($env.NIXPKGS_ALLOW_UNFREE = 1; nix run --impure $"nixpkgs#($c)" "--" ...$rest)
      }

      # alias: $env.NIXPKGS_ALLOW_UNFREE = 1; nix shell --impure nixpkgs#<package> -- <options>
      # to: nixshell-unfree <package> <options>
      def --wrapped nixshell-unfree [c, ...rest] {
          ($env.NIXPKGS_ALLOW_UNFREE = 1; nix shell --impure $"nixpkgs#($c)" "--" ...$rest)
      }
    '';
    shellAliases = {
      hello = "echo 'Hello, world!'";
    };
  };
  programs.nix-your-shell = {
    enable = true;
    enableNushellIntegration = true;
  };
}
