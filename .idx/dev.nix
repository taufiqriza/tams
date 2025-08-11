{ pkgs, ... }:
{
  channel = "stable-24.05";
  packages = [
    pkgs.php
    pkgs.composer
    pkgs.nodejs_20
    pkgs.mysql
    pkgs.git
  ];

  idx = {
    previews = {
      enable = true;
      previews = {
        web = {
          command = [
            "php" "artisan" "serve" "--host" "0.0.0.0" "--port" "$PORT"
          ];
          manager = "web";
        };
      };
    };

    workspace = {
      onCreate = {
        setup = ''
          if [ ! -f artisan ]; then
            composer create-project laravel/laravel . --no-interaction
            composer require filament/filament --no-interaction
            php artisan key:generate
          fi
        '';
      };
    };
  };
}
