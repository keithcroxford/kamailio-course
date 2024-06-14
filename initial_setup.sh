#  PROCEED WITH CAUTION - as this will delete the db folder 
#  This script will provide the initial database config
#  needed to start kamailio from the main branch w/out starting from the first course/branch

# Shutdown docker-compose  
echo "*Shutdown the docker compose environment*"
docker compose down
#
echo "*Deleting the DB volume*"
sudo rm -rf db
mkdir db

#obtain the minimal config to start kamailio
echo "*Obtaining the Kamailio Minimal Config and renaming to kamailio.cfg*"
curl https://raw.githubusercontent.com/kamailio/kamailio/master/misc/examples/mixed/kamailio-minimal-proxy.cfg -o ./kamailio-default/etc/kamailio/kamailio.cfg

# Run the Docker container
echo "*Starting Docker the inital DB will be created, yet blank* "
docker compose up -d

echo "*sleep for 10 seconds. Allow everything to boot*"
sleep 10

# Run kamdbctl create inside the Docker container
echo "*RECREATE AND REINIT THE KAMAILIO DB*" 
docker exec kamailio-edge sh -c  "yes y | kamdbctl reinit kamailio"

# add the RTPEngine instance to the DB
echo "*ADDING RTPENGINE TO THE DB" 
docker exec kamailio-edge sh -c "query=\$(cat /etc/kamailio/sql/rtpengine.sql) ; kamctl db exec \"\$query\""

# Move the proper file back to kamailio.cfg
echo "*Obtaining the proper kamailio.cfg*"
curl https://raw.githubusercontent.com/keithcroxford/kamailio-course/main/kamailio-default/etc/kamailio/kamailio.cfg -o ./kamailio-default/etc/kamailio/kamailio.cfg

docker restart kamailio-edge
