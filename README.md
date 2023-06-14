# Bahmni Docker

Refer this [Wiki Page](https://bahmni.atlassian.net/wiki/spaces/BAH/pages/299630726/Running+Bahmni+on+Docker) for Running Bahmni on Docker for detailed instructions.
This contains snomed-clinic / snomed-standard profile. More details can be found [here](https://bahmni.atlassian.net/wiki/spaces/BAH/pages/3132686337/SNOMED+FHIR+Terminology+Server+Integration+with+Bahmni)

# To start SNOMED CLINIC or STANDARD using docker compose:
1. Go to snomed-clinic or snomed-standard subfolder. For example: `cd snomed-clinic`.
2. Execute script: `./run-bahmni.sh`. This will give you options for start/stop/view-logs/pull/reset/etc.
3. Ensure your `.env` file in the sub-folder has correct PROFILE configured, before executing the above commands.  