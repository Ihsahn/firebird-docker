#!/bin/bash
set -e

echo "Starting fbguard"

/opt/firebird/bin/fbguard &

if [ "$1" = 'firebird' ]; then

echo "Firebird command detected"

OrigPasswd=`grep -oP 'ISC_PASSWD=\K.*' /opt/firebird/SYSDBA.password`

if [ "$OrigPasswd" != "$FIREBIRD_PASSWORD" ]; then
    echo "New password providerd"

    echo "Wait until Firebird server starts (fbserver process)"

   while ! ps aux |grep -v grep| grep fbserver; do echo "."; sleep 1; done ;

   echo "Replacing password"

  /opt/firebird/bin/gsec -user sysdba -password $OrigPasswd -modify sysdba -pw $FIREBIRD_PASSWORD
  echo "Save password into /opt/firebird/SYSDBA.password"
  sed -i 's/ISC_PASSWD=.*/ISC_PASSWD='"$FIREBIRD_PASSWORD"'/' /opt/firebird/SYSDBA.password
fi

  exec tail -f /dev/null
else
  exec "$@"
fi
