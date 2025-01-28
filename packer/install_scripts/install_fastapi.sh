#!/bin/bash
set -eux

# Install Python and pip
sudo apt-get install -y python3 python3-pip

# Install FastAPI and dependencies
sudo pip3 install fastapi uvicorn grpcio pocketbase-client

# Copy FastAPI app to `/opt`
sudo mkdir -p /opt/fastapi_app
sudo cp -r /vagrant/fastapi_app/* /opt/fastapi_app

# Create systemd service for FastAPI
sudo tee /etc/systemd/system/fastapi.service > /dev/null <<EOF
[Unit]
Description=FastAPI Server
After=network.target

[Service]
User=ubuntu
WorkingDirectory=/opt/fastapi_app
ExecStart=/usr/bin/python3 -m uvicorn app.main:app --host 0.0.0.0 --port 8000
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Enable and start FastAPI service
sudo systemctl enable fastapi
sudo systemctl start fastapi
