## Bahmni Docker

Refer to this [Wiki Page](https://bahmni.atlassian.net/wiki/spaces/BAH/pages/299630726/Running+Bahmni+on+Docker) on detailed instructions for running Bahmni on Docker.

## SNOMED Integration
This deployment comes with two profiles i.e **_snomed-clinic_** and **_snomed-standard_**. More details can be found [here](https://bahmni.atlassian.net/wiki/spaces/BAH/pages/3132686337/SNOMED+FHIR+Terminology+Server+Integration+with+Bahmni)

### To start SNOMED CLINIC or STANDARD using docker compose
1. Go to snomed-clinic or snomed-standard subfolder. For example: `cd snomed-clinic`.
2. Execute script: `./run-bahmni.sh`. This will give you options for start/stop/view-logs/pull/reset/etc.
3. Ensure your `.env` file in the sub-folder has correct PROFILE configured, before executing the above commands.  
