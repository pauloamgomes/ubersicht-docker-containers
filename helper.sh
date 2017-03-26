#! /bin/bash

export PATH=$PATH:/usr/local/bin

getStatus() {
  docker ps --format "table {{.ID}}|{{.Names}}|{{.Size}}|{{.Status}}" | grep -v CONTAINER
}

restart() {
  docker container restart $1
}

shell() {
  osascript -e 'tell application "Terminal" to do script "docker exec -it '$1' sh"'
}


"$@"
