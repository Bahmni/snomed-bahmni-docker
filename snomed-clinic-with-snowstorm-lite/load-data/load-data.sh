#!/bin/sh

snowstorm_lite_url="http://snowstorm-lite:8080/fhir"

# Wait for the Snowstorm Lite Server to start
while true; do
  http_status_code=$(curl -s -o /dev/null -w "%{http_code}" $snowstorm_lite_url)

  if [ "$http_status_code" -eq 200 ]; then
    echo "Snowstorm Lite Server is up and running!"
    break
  else
    echo "HTTP status code $http_status_code - Not OK, retrying in 5 seconds...";
    sleep 5
  fi
done

# Make a POST API call to load data
curl -v -u admin:Admin@123 --form file='@/snowstorm-data/snomed-data.zip' --form version-uri="http://snomed.info/sct/900000000000207008/version/20230731" http://snowstorm-lite:8080/fhir-admin/load-package
echo "Data Loaded Successfully"