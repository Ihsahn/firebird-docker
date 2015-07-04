#!/bin/bash
set -e

echo "Start fbguard"

/opt/firebird/bin/fbguard &

if [ "$FIREBIRD_PASSWORD" ]; then
    echo "New password providerd, altering"

    echo "Wait until Firebird server starts (2 sec)"

    sleep 2

    OrigPasswd=`grep -oP 'ISC_PASSWD=\K.*' /opt/firebird/SYSDBA.password`
    /opt/firebird/bin/gsec -user sysdba -password $OrigPasswd -modify sysdba -pw $FIREBIRD_PASSWORD
fi

if [ "$1" = 'firebird' ]; then
  exec tail -f /dev/null
else
  exec "$@"
fi
