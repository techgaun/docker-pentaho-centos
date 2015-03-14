#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <pg_hostname>"
    exit
fi

docker run --name=postgres -d -p 5432:5432 wmarinho/postgresql:9.3
sleep 30 
docker run  --name=pentaho01 -d  -p 8080:8080 -e INSTALL_PLUGIN=marketplace,cdf,cda,cde,cgg,sparkl,saiku -e  DB_PORT=5432  -e DB_DB_NAME=postgres  -e DB_USERNAME=pgadmin  -e DB_HOSTNAME=$1  -e DB_PASSWORD=pgadmin. -e DB_VENDOR=postgres techgaun/pentaho:5.2
#sleep 360 
#docker run  --name=pentaho02 -d  -p 8081:8080 -e INSTALL_PLUGIN=marketplace,cdf,cda,cde,cgg,sparkl,saiku  -e  DB_PORT=5432  -e DB_DB_NAME=postgres  -e DB_USERNAME=pgadmin  -e DB_HOSTNAME=$1  -e DB_PASSWORD=pgadmin. -e DB_VENDOR=postgres wmarinho/pentaho
sleep 60
docker run --name=pdi -d -p 8181:8181 -e CARTE_USER=techgaun -e CARTE_PASS=techgaun techgaun/kettle:5.2
