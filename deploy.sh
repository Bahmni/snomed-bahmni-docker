config_directory=""
snomed_profile=""
#git pull
cd /home/ec2-user/snomed-data/bahmni-docker/snomed-standard
docker compose --profile snomed-standard down -v
cd /home/ec2-user/snomed-data/bahmni-docker/snomed-clinic
docker compose --profile snomed-clinic down -v
cd /home/ec2-user/snomed-data/bahmni-docker/snomed-standard-with-snowstorm-lite
docker compose --profile snomed-standard down -v
cd /home/ec2-user/snomed-data/bahmni-docker/snomed-clinic-with-snowstorm-lite
docker compose --profile snomed-clinic down -v
snowstorm_lite_profile=""
if [ "Standard" = "$2" ]; then
    echo "starting from default config"
    config_directory="/home/ec2-user/snomed-data/bahmni-docker/snomed-standard"
    snomed_profile="snomed-standard"
else
    echo "starting from clinic config"
    config_directory="/home/ec2-user/snomed-data/bahmni-docker/snomed-clinic"
    snomed_profile="snomed-clinic"
fi

if ([ "Standard" = "$2" ] && [ "Lite" = "$5" ]) then
    echo "starting from default config with snowstorm lite"
    config_directory="/home/ec2-user/snomed-data/bahmni-docker/snomed-standard-with-snowstorm-lite"
    snomed_profile="snomed-standard"
elif ([ "Clinic" = "$2" ] && [ "Lite" = "$5" ]) then
    echo "starting from clinic config with snowstorm lite"
    config_directory="/home/ec2-user/snomed-data/bahmni-docker/snomed-clinic-with-snowstorm-lite"
    snomed_profile="snomed-clinic"
fi

echo "Config Directory : $config_directory"
echo "SNOMED Profile : ${snomed_profile}"

cd $config_directory
#docker compose --profile ${snomed_profile} down -v
docker compose --profile ${snomed_profile} up --pull=always -d
docker system prune -af
cd /home/ec2-user/snomed-data/bahmni-docker

nohup ./updateGlobalProperties.sh "$5" &

