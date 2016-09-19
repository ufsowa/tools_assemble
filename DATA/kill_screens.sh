#!/bin/bash

echo "Closing:"
for session in $(screen -ls | grep -o '[0-9]*\.sS[0-9]' )
do
#    echo $session
    session=`echo $session  | grep -o '[0-9]\{2,\}' | head -1`
    echo $session
    screen -S "${session}" -wipe;
    screen -S "${session}" -X quit;
done
echo "Still in use:"
screen -ls