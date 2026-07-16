{ config, ... }:
{
    age.secrets.airvpn-key = {
        file = ./../../../secrets/airvpn-key.age;
        mode = "600";
    };

    age.secrets.airvpn-psk = {
        file = ./../../../secrets/airvpn-psk.age;
        mode = "600";
    };
    
    networking.wg-quick.interfaces.airvpn = {
        address = [
            "10.141.204.161/32"
            "fd7d:76ee:e68f:a993:2624:7456:c62e:159a/128"
        ];

        mtu = 1320;

        dns = [
            "10.128.0.1"
            "fd7d:76ee:e68f:a993::1"
        ];

        privateKeyFile = config.age.secrets.airvpn-key.path;

        peers = [
            {
            publicKey = "PyLCXAQT8KkM4T+dUsOQfn+Ub3pGxfGlxkIApuig+hk=";
            presharedKeyFile = config.age.secrets.airvpn-psk.path;

            endpoint = "nl3.vpn.airdns.org:1637";

            allowedIPs = [
                "0.0.0.0/0"
                "::/0"
            ];

            persistentKeepalive = 15;
            }
        ];
    };
}