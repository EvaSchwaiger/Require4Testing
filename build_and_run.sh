#!/bin/bash

# Das Skript startet die Webanwendung Require4Testing
set -e

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TOMCAT_WEBAPPS="/opt/tomcat/webapps"
WAR_FILE="Require4Testing-1.0-SNAPSHOT.war"

echo "=== Building the project ==="
cd "$PROJECT_DIR"
mvn clean package

echo "=== Deploying to Tomcat ==="
sudo cp "target/$WAR_FILE" "$TOMCAT_WEBAPPS/"

echo "=== Restarting Tomcat ==="
sudo systemctl restart tomcat

echo "=== Deployment complete ==="
echo "Application should be available at http://localhost:8080/$WAR_FILE (without .war extension)"