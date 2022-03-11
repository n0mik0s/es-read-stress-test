#!/bin/bash

printf "ES host: "
read host

printf "User: "
read user

stty -echo
printf "Password: "
read pass
stty echo
printf "\n"

get_func(){
    curl -k --user "$user":"$pass" -X GET "https://$host:9200/_search?pretty" -H 'Content-Type: application/json' -d'"$1"'
}
 
while IFS= read -r js
do
    get_func "$js" &
done < list.txt
 
wait
echo "All done."