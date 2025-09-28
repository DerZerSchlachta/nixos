{ ... }:
{
  home.file.".config/jellyfin-rpc/main.json".text = ''
  {
      "jellyfin": {
          "url": "http://100.96.116.4:8096",
          "api_key": "b2d1c23ce4cc4fbbbe88f02dc6c70496",
          "username": ["Johannes"]
      },
      "discord": {
          "application_id": "1395124384481677433",
          "buttons": [
              {
                  "name": "dynamic",
                  "url": "dynamic"
              },
              {
                  "name": "dynamic",
                  "url": "dynamic"
              }
          ]
      },
      "images": {
          "enable_images": true,
          "imgur_images": true
      }
  }
  '';
}
