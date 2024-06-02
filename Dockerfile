version: "3"
Services    
    gluetun:
        image: qmcgaw/gluetun
        container_name: gluetun
        hostname: gluetun
        cap_add:
        - NET_ADMIN
        ports:
        - 6881:6881
        - 6881:6881/udp
        - 8080:8080
        - 8989:8989
        - 9696:9696
        - 7878:7878
        volumes:
        - /var/dockerd/gluetun:/gluetun
        environment:
            - VPN_SERVICE_PROVIDER=airvpn
            - VPN_TYPE=wireguard
            - WIREGUARD_PRIVATE_KEY=aCqB66yuU6W3oeQCJQ8JtY3Xn7DyFw/4cWO5aHQS9Xc=
            - WIREGUARD_PRESHARED_KEY=OCE3Kr+T96roVBfa1GsrAt5ME0ZfMg+KImNNjMWbIqw=
            - WIREGUARD_ADDRESSES=10.189.12.89,fd7d:76ee:e68f:a993:c557:b942:67c5:4b38
            - SERVER_COUNTRIES=Netherlands
            - FIREWALL_VPN_INPUT_PORTS=57400
        restart: always

    qbittorrent:
        image: lscr.io/linuxserver/qbittorrent
        container_name: qbittorrent
        network_mode: "service:gluetun"
        environment:
        - PUID=1000
        - PGID=1001
        - TZ=Europe/London
        - WEBUI_PORT=8085
        volumes:
        - /Users/ambitiousicey/Desktop/Qbitorrent/Config:/config
        - /Users/ambitiousicey/Desktop/Qbitorrent/Downloads:/downloads
        depends_on:
        - gluetun
        restart: always
       
    sonarr:
        image: lscr.io/linuxserver/sonarr:latest
        container_name: sonarr
        environment:
        - PUID=diaboliquebassoon
        - PGID=Funkyhat42!
        - TZ=Europe/Copenhagen
        - volumes:
        - /Users/ambitiousicey/Desktop/Plex/Tvshows/sonarr:/config
        - /Users/ambitiousicey/Desktop/Plex/Tvshows/downloads/downloads:/downloads #optional
        restart: unless-stopped

    radarr:
        image: lscr.io/linuxserver/radarr:latest
        container_name: radarr
        environment:
        - PUID=diaboliquebassoon
        - PGID=Funkyhat42!
        - TZ=Europe/Copenhagen
        volumes:
        - /Users/ambitiousicey/Desktop/Plex/Movies/radarr:/config
        - /Users/ambitiousicey/Desktop/Plex/Movies/downloads/downloads:/downloads #optional
        restart: unless-stopped

    prowlarr:
        image: lscr.io/linuxserver/prowlarr:latest
        container_name: prowlarr
        environment:
        - PUID=diaboliquebassoon
        - PGID=Funkyhat42!
        - TZ=Europe/Copenhagen
        volumes:
        - /Users/ambitiousicey/Desktop/Plex/Prowlarr/prowlarr:/config
        restart: unless-stopped