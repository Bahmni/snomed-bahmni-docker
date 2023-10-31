#!/bin/bash

TEMPFILE="$(mktemp)"
STARTTIME="$(date +%s)"

while [ -f "$TEMPFILE" ]; do
    sleep 1s
    NOW="$(date +%s)"
    if (( (NOW-STARTTIME) % 400 == 0 )); then
	break
    fi
done
docker cp ./updateProperties.sql snomed-standard-openmrsdb-1:/
docker exec snomed-standard-openmrsdb-1 /bin/sh -c 'mysql -u root -padminAdmin!123 < /updateProperties.sql'
docker cp ./updateProperties.sql snomed-clinic-openmrsdb-1:/
docker exec snomed-clinic-openmrsdb-1 /bin/sh -c 'mysql -u root -padminAdmin!123 < /updateProperties.sql'
docker cp ./updateProperties.sql snomed-standard-with-snowstorm-lite-openmrsdb-1:/
docker exec snomed-standard-with-snowstorm-lite-openmrsdb-1 /bin/sh -c 'mysql -u root -padminAdmin!123 < /updateProperties.sql'
docker cp ./updateProperties.sql snomed-clinic-with-snowstorm-lite-openmrsdb-1:/
docker exec snomed-clinic-with-snowstorm-lite-openmrsdb-1 /bin/sh -c 'mysql -u root -padminAdmin!123 < /updateProperties.sql'

echo "Done Updating Global Properties!!!"

echo "Update Search Index"
curl --location --request POST 'http://localhost:8080/openmrs/ws/rest/v1/searchindexupdate' --header 'Authorization: Basic c3VwZXJtYW46QWRtaW4xMjM='

if [ "Lite" = "$1" ]; then
    echo "Updating Global Properties for SNOWSTORM LITE"
    docker cp ./updateSnowstormLite.sql snomed-standard-with-snowstorm-lite-openmrsdb-1:/
    docker exec snomed-standard-with-snowstorm-lite-openmrsdb-1 /bin/sh -c 'mysql -u root -padminAdmin!123 < /updateSnowstormLite.sql'
    docker cp ./updateSnowstormLite.sql snomed-clinic-with-snowstorm-lite-openmrsdb-1:/
    docker exec snomed-clinic-with-snowstorm-lite-openmrsdb-1 /bin/sh -c 'mysql -u root -padminAdmin!123 < /updateSnowstormLite.sql'
fi