#!/bin/bash
secertspath=$1
listSecrets=$(ls $secertspath)
for secret in $listSecrets
do
	secert_name="$secertspath$secret"
        echo -e "\nDecode secret : $secret"
        cat $secert_name | jq -r '.data.namespace' | base64 -d
        echo ""
        cat $secert_name | jq -r '.metadata.creationTimestamp'
        echo ""
        jwt=$(cat $secert_name | jq -r '.data.token' | base64 -d)
        ./jwtDecoder.sh $jwt
        echo ""
        echo -e "------------------------------\n"
done
