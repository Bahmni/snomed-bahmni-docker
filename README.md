## Bahmni Docker

Refer to this [Wiki Page](https://bahmni.atlassian.net/wiki/spaces/BAH/pages/299630726/Running+Bahmni+on+Docker) on detailed instructions for running Bahmni on Docker.

## SNOMED Integration
This deployment comes with two profiles i.e **_snomed-clinic_** and **_snomed-standard_**. More details can be found [here](https://bahmni.atlassian.net/wiki/spaces/BAH/pages/3132686337/SNOMED+FHIR+Terminology+Server+Integration+with+Bahmni)

### To start SNOMED CLINIC or STANDARD using docker compose
1. Go to snomed-clinic or snomed-standard subfolder. For example: `cd snomed-clinic`.
2. Execute script: `./run-bahmni.sh`. This will give you options for start/stop/view-logs/pull/reset/etc.
3. Ensure your `.env` file in the sub-folder has correct PROFILE configured, before executing the above commands.  

### Known Issues with SNOMED CLINIC
1. For any concept supporting multiple languages, the form builder report displays all the languages against
   the corresponding concept. For more details, refer to [this](https://bahmni.atlassian.net/jira/software/c/projects/BAH/issues/BAH-3066) link
2. 'Procedure Orders' concept is not automatically added as set member under 'All Orderables' after SNOMED CLINIC deployment.
   As a workaround 'Procedure Orders' needs to be manually added as set member under 'All Orderables' using OpenMRS concept
   dictionary. For more details refer to [this](https://bahmni.atlassian.net/browse/BS-170) link
