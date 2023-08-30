# eea.docker.traefik-helper

Container to help traefik service to download custom plugins and set up file permission for prometheus and grafana.

Uses volume on `/plugins-local`.

Add `$GEOBLOCKING=true` variable to download the github.com/kucjac/traefik-plugin-geoblock `$GEOBLOCKING_VERSION` release. 
It also downloads the latest `IP2LOCATION-LITE-DB1.IPV6.BIN.ZIP` file and extracts its contents, overwritting the old version of the BIN file from the plugin.
You need to schedule it to run monthly, in order to get the newest file. 



