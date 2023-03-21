#!/bin/bash

set -e 

echo "Running traefik helper container"


if [[ ! "$@" == "run" ]]; then
  exec "$@"
  exit 0
fi


mkdir -p /plugins-local/src


if [[ "$GEOBLOCKING" == "true" ]]; then
	
   
   cd /plugins-local/src

   if [ -f /plugins-local/versions.log ] && [ $(grep github.com/kucjac/traefik-plugin-geoblock /plugins-local/versions.log | tail -n 1 | grep "- ${GEOBLOCKING_VERSION}$" | wc -l) -eq 0 ]; then
	   echo "Did not find geoblocking plugin, or found old version, making sure the directory is empty to be cloned from github"
	   rm -rf github.com/kucjac/traefik-plugin-geoblock
   fi


   if [ ! -d github.com/kucjac/traefik-plugin-geoblock ]; then
      echo "Cloning geoblocking plugin, version ${GEOBLOCKING_VERSION}"
      git clone -b ${GEOBLOCKING_VERSION} https://github.com/kucjac/traefik-plugin-geoblock.git github.com/kucjac/traefik-plugin-geoblock
      echo "$date - github.com/kucjac/traefik-plugin-geoblock - ${GEOBLOCKING_VERSION}" >> /plugins-local/versions.log
   fi

   cd /plugins-local
   rm -rf temp
   mkdir temp
   cd temp
   echo "Updating IP2LOCATION-LITE-DB1.IPV6.BIN.ZIP file"
   wget https://download.ip2location.com/lite/IP2LOCATION-LITE-DB1.IPV6.BIN.ZIP
   if [ $? -eq 0 ]; then
         echo "Downloaded archive"
         unzip IP2LOCATION-LITE-DB1.IPV6.BIN.ZIP
         if [ $? -eq 0 ]; then
	   echo "Extracted archive, moving new file to plugin location"
	   ls -ltr IP2LOCATION-LITE-DB1.IPV6.BIN
	   mv IP2LOCATION-LITE-DB1.IPV6.BIN /plugins-local/src/github.com/kucjac/traefik-plugin-geoblock/
	   ls -ltr /plugins-local/src/github.com/kucjac/traefik-plugin-geoblock/
         fi
   fi
   cd /plugins-local
   rm -rf temp

fi


# make sure prometheus has correct permissions
if [ -d /etc/prometheus ]; then
	chown 65534:65534 /etc/prometheus
	chmod 755 /etc/prometheus
fi

# make sure grafana has correct permission
if [ -d /var/lib/grafana ]; then

	chown 472:0 /var/lib/grafana
	chmod 755 /var/lib/grafana
fi
