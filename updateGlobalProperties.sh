#!/bin/bash

openmrs_url="http://localhost:8080/openmrs/ws/rest/v1/session"

# Wait for the OpenMRS Server to start
while true; do
  http_status_code=$(curl -s -o /dev/null -w "%{http_code}" $openmrs_url)

  if [ "$http_status_code" -eq 200 ]; then
    echo "OpenMRS Lite Server is up and running!"
    break
  else
    echo "HTTP status code $http_status_code - Not OK, retrying in 15 seconds...";
    sleep 15
  fi
done

curl --location 'http://localhost:8080/openmrs/ws/rest/v1/systemsetting/bahmni.lookupExternalTerminologyServer' --header 'Content-Type: application/json' --header 'Authorization: Basic c3VwZXJtYW46QWRtaW4xMjM=' --data '{ "value": "true" }'
curl --location 'http://localhost:8080/openmrs/ws/rest/v1/systemsetting/cdss.fhir.baseurl' --header 'Content-Type: application/json' --header 'Authorization: Basic c3VwZXJtYW46QWRtaW4xMjM=' --data '{ "value": "http://cdss:8080/cds-services" }'
curl --location 'http://localhost:8080/openmrs/ws/rest/v1/systemsetting/cdss.enable' --header 'Content-Type: application/json' --header 'Authorization: Basic c3VwZXJtYW46QWRtaW4xMjM=' --data '{ "value": "true" }'
curl --location 'http://localhost:8080/openmrs/ws/rest/v1/systemsetting/fhir.export.anonymise.config.path' --header 'Content-Type: application/json' --header 'Authorization: Basic c3VwZXJtYW46QWRtaW4xMjM=' --data '{ "value": "/openmrs/data/fhir-export-anonymise-config.json" }'
curl --location 'http://localhost:8080/openmrs/ws/rest/v1/systemsetting/ts.fhir.baseurl' --header 'Content-Type: application/json' --header 'Authorization: Basic c3VwZXJtYW46QWRtaW4xMjM=' --data '{ "value": "https://snowstorm.snomed.mybahmni.in/fhir/" }'
curl --location 'http://localhost:8080/openmrs/ws/rest/v1/systemsetting/ts.fhir.conceptDetailsUrl' --header 'Content-Type: application/json' --header 'Authorization: Basic c3VwZXJtYW46QWRtaW4xMjM=' --data '{ "value": "http://snomed.info/sct?fhir_vs=ecl/{0}" }'
curl --location 'http://localhost:8080/openmrs/ws/rest/v1/systemsetting/ts.fhir.diagnosissearch.valueseturl' --header 'Content-Type: application/json' --header 'Authorization: Basic c3VwZXJtYW46QWRtaW4xMjM=' --data '{ "value": "http://snomed.info/sct?fhir_vs=ecl/<404684003" }'
curl --location 'http://localhost:8080/openmrs/ws/rest/v1/systemsetting/ts.fhir.valueset.urltemplate' --header 'Content-Type: application/json' --header 'Authorization: Basic c3VwZXJtYW46QWRtaW4xMjM=' --data '{ "value": "ValueSet/$expand?url={0}&filter={1}&count={2}&displayLanguage={3}&includeDesignations={4}" }'
curl --location 'http://localhost:8080/openmrs/ws/rest/v1/systemsetting/ts.fhir.observation.valueset.urltemplate' --header 'Content-Type: application/json' --header 'Authorization: Basic c3VwZXJtYW46QWRtaW4xMjM=' --data '{ "value": "ValueSet/$expand?url={0}&displayLanguage={1}&_format={2}&filter={3}&count={4}" }'
curl --location 'http://localhost:8080/openmrs/ws/rest/v1/systemsetting/ts.fhir.diagnosiscount.valueseturl' --header 'Content-Type: application/json' --header 'Authorization: Basic c3VwZXJtYW46QWRtaW4xMjM=' --data '{ "value": "http://snomed.info/sct?fhir_vs=ecl/<<" }'
curl --location 'http://localhost:8080/openmrs/ws/rest/v1/systemsetting/ts.fhir.diagnosiscount.valueset.urltemplate' --header 'Content-Type: application/json' --header 'Authorization: Basic c3VwZXJtYW46QWRtaW4xMjM=' --data '{ "value": "ValueSet/$expand?url={0}{1}&displayLanguage={2}&count={3,number,#}&offset={4,number,#}" }'
curl --location 'http://localhost:8080/openmrs/ws/rest/v1/systemsetting/ts.fhir.procedure.valueset.urltemplate' --header 'Content-Type: application/json' --header 'Authorization: Basic c3VwZXJtYW46QWRtaW4xMjM=' --data '{ "value": "http://bahmni.org/fhir/ValueSet/" }'

if [ "Lite" = "$1" ]; then
    echo "Updating Global Properties for SNOWSTORM LITE"
    curl --location 'http://localhost:8080/openmrs/ws/rest/v1/systemsetting/ts.fhir.baseurl' --header 'Content-Type: application/json' --header 'Authorization: Basic c3VwZXJtYW46QWRtaW4xMjM=' --data '{ "value": "http://snowstorm-lite:8080/fhir/" }'
fi

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
