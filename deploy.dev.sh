curl -fsSL https://get.docker.com | sh

mkdir -p $HOME/compose/
mkdir -p $HOME/compose/certs/

sudo tee $HOME/compose/compose.yml << EOL
services:
  reverse-proxy:
    image: nginx:alpine
    restart: unless-stopped
    container_name: reverse-proxy
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
      - ./certs:/etc/nginx/certs:ro
    networks:
      - proxy-network

  # An example backend service (isolated from the public)
  web-app:
    image: tollbark/venus-ui
    restart: unless-stopped
    container_name: venus-ui
    networks:
      - proxy-network

networks:
  proxy-network:
    driver: bridge
EOL

sudo tee $HOME/compose/nginx.conf << EOL
events {}

http {
    # Automatically redirect HTTP (80) to HTTPS (443)
    server {
        listen 80;
        server_name dev.aidsbooger.com;
        return 301 https://\$host\$request_uri;
    }

    # Handle secure HTTPS (443) traffic
    server {
        listen 443 ssl;
        server_name dev.aidsbooger.com;

        ssl_certificate /etc/nginx/certs/fullchain.pem;
        ssl_certificate_key /etc/nginx/certs/privkey.pem;

        location / {
            proxy_pass http://web-app:3000; # Uses container name and internal port
            proxy_set_header Host \$host;
            proxy_set_header X-Real-IP \$remote_addr;
            proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto \$scheme;
        }
    }
}
EOL

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout $HOME/compose/certs/privkey.pem \
  -out $HOME/compose/certs/fullchain.pem \
  -subj "/CN=example.com"

sudo tee $HOME/startup.sh << EOL
#!/bin/bash
docker compose -f $HOME/compose/compose.yml down
docker compose -f $HOME/compose/compose.yml up -d
EOL
chmod +x $HOME/startup.sh

sudo tee /etc/systemd/system/venus.service > /dev/null << EOL
[Unit]
Description=Venus Startup Script
After=network.target docker.service
Requires=docker.service

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=$HOME/startup.sh
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOL

sudo systemctl daemon-reload
sudo systemctl enable venus.service
sudo systemctl start venus