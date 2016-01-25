# firebird-docker
Dockerfile for Firebird Databaseserver

This is *Dockerfile* for Firebird 2.5 SuperServer.


Howto create container:

docker create -v /home/ihsahn/docker_volumes/firebird_2.0:/var/lib/firebird/data -p 3050:3050 --name firebird  -e FIREBIRD_PASSWORD=sysdba_passwd ihsahn/firebird-docker:2.5
