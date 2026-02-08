#!/bin/bash

# Stop on any error
set -e

TOMCAT_VERSION=9.0.85
TOMCAT_USER=tomcat
INSTALL_DIR=/opt/tomcat

echo "=== Installing Java ==="
sudo apt update
sudo apt install -y openjdk-11-jdk

echo "=== Creating tomcat user ==="
sudo useradd -m -U -d $INSTALL_DIR -s /bin/false $TOMCAT_USER || true

echo "=== Downloading Tomcat ==="
cd /tmp
wget https://archive.apache.org/dist/tomcat/tomcat-9/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz

echo "=== Installing Tomcat ==="
sudo mkdir -p $INSTALL_DIR
sudo tar xzf apache-tomcat-$TOMCAT_VERSION.tar.gz -C $INSTALL_DIR --strip-components=1

echo "=== Setting permissions ==="
sudo chown -R $TOMCAT_USER:$TOMCAT_USER $INSTALL_DIR
sudo chmod -R 755 $INSTALL_DIR

echo "=== Creating systemd service ==="
sudo tee /etc/systemd/system/tomcat.service > /dev/null <<EOF
[Unit]
Description=Apache Tomcat
After=network.target

[Service]
Type=forking

User=$TOMCAT_USER
Group=$TOMCAT_USER

Environment="JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64"
Environment="CATALINA_PID=$INSTALL_DIR/temp/tomcat.pid"
Environment="CATALINA_HOME=$INSTALL_DIR"
Environment="CATALINA_BASE=$INSTALL_DIR"

ExecStart=$INSTALL_DIR/bin/startup.sh
ExecStop=$INSTALL_DIR/bin/shutdown.sh

Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

echo "=== Enabling and starting Tomcat ==="
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable tomcat
sudo systemctl start tomcat

echo "=== Tomcat installation complete ==="
echo "Open: http://localhost:8080"
