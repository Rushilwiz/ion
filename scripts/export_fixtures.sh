#!/bin/bash
set -e

if ! [ -d "fixtures" ]; then
    echo "No fixtures folder found!"
    exit
fi

TABLES=$(psql -d ion -c "SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';" -t)

for x in $TABLES; do
    if [[ $x == oauth* ]]; then continue; fi
    if [[ $x == django* ]]; then continue; fi
    if [[ $x == itemreg* ]]; then continue; fi
    if [[ $x == lostfound* ]]; then continue; fi
    if [[ $x == notifications* ]]; then continue; fi
    if [[ $x == parking* ]]; then continue; fi
    if [[ $x == signage* ]]; then continue; fi
    if [[ $x == seniors* ]]; then continue; fi
    if [[ $x == printing* ]]; then continue; fi
    if [[ $x == polls* ]]; then continue; fi
    if [[ $x == board* ]]; then continue; fi
    if [[ $x == feedback* ]]; then continue; fi
    if [[ $x == ionldap* ]]; then continue; fi
    if [[ $x == *historical* ]]; then continue; fi
    pg_dump -d ion -t $x -O -a --disable-triggers > fixtures/$x.sql
    echo "Exported $x"
done
