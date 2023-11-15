## Bahmni Docker

Refer to this [Wiki Page](https://bahmni.atlassian.net/wiki/spaces/BAH/pages/299630726/Running+Bahmni+on+Docker) on detailed instructions for running Bahmni on Docker.

### Note : This repository is used to run entire SNOMED Integration with Bahmni. 

### Local Deployment guide is [here](https://bahmni.atlassian.net/wiki/spaces/BAH/pages/3183345706/Bahmni-SNOMED+Integration+Local+Deployment+Guide)

## SNOMED Integration
This deployment comes with two profiles i.e **_snomed-clinic_** and **_snomed-standard_**. More details can be found [here](https://bahmni.atlassian.net/wiki/spaces/BAH/pages/3132686337/SNOMED+FHIR+Terminology+Server+Integration+with+Bahmni)

We are also bundling snowstorm lite server. More details can be found [here](https://bahmni.atlassian.net/wiki/spaces/BAH/pages/3132686337/SNOMED+FHIR+Terminology+Server+Integration+with+Bahmni#Implementation-of-micro-FHIR-terminology-server-for-low-resource-settings)

### To start SNOMED CLINIC or STANDARD using docker compose (External SNOMED Server)
1. Go to snomed-clinic or snomed-standard subfolder. For example: `cd snomed-clinic`.
2. Execute script: `./run-bahmni.sh`. This will give you options for start/stop/view-logs/pull/reset/etc.
3. Ensure your `.env` file in the sub-folder has correct PROFILE configured, before executing the above commands. Make sure the JVM argument _fhir.terminology-server.url_ in the environment variable **CDSS_JAVA_SERVER_OPTS** is set to the valid SNOMED FHIR Server URL. 

### To start SNOMED CLINIC or STANDARD along with SNOWSTORM LITE Server using docker compose 

To use Snowstorm Lite server along with SNOMED CLINIC or STANDARD, please follow the below steps:
1. Go to snomed-clinic-with-snowstorm-lite or snomed-standard-with-snowstorm-lite subfolder. For example: `cd snomed-standard-with-snowstorm-lite`.
2. Update _SNOWSTORM_RF2_FILE_PATH_ with RF2 file path from SNOMED and _admin.password_ in the .env file.
3. Replace `<UPDATE_PASSWORD_HERE>` with the same _admin.password_ in the load-data.sh file.

### Known Issues with SNOMED CLINIC
1. For any concept supporting multiple languages, the form builder report displays all the languages against
   the corresponding concept. For more details, refer to [this](https://bahmni.atlassian.net/jira/software/c/projects/BAH/issues/BAH-3066) link
2. 'Procedure Orders' concept is not automatically added as set member under 'All Orderables' after SNOMED CLINIC deployment.
   As a workaround 'Procedure Orders' needs to be manually added as set member under 'All Orderables' using OpenMRS concept
   dictionary. For more details refer to [this](https://bahmni.atlassian.net/browse/BS-170) link
