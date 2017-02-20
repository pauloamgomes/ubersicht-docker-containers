#! /bin/bash

export PATH=$PATH:/usr/local/bin

getStatus() {
  docker ps --format "table {{.ID}}|{{.Names}}|{{.Size}}|{{.Status}}" | grep -v CONTAINER
}

"$@"
