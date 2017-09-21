#!/bin/bash

response=`curl -X POST -H "Authorization: Basic YWRtaW46YWRtaW4=" -H "Content-Type: application/json" -d '{"clientName":"Test","redirect_uris":"www.google.lk","grant_types":"password"}' "https://localhost:9443/identity/connect/register" -k`
echo "$response"
client_id=`echo $response | jq -r '.client_id'`
client_secret=`echo $response | jq -r '.client_secret'`
header=`echo "$client_id:$client_secret"|base64`
echo "$header"
header=${header::${#header}-4}

echo "curl -X POST -H "Authorization: Bearer $header" -H "Content-Type: application/x-www-form-urlencoded"  -d 'grant_type=password&username=admin&password=admin&validity_period=-1' "https://localhost:9443/oauth2/token" -k"
response2=`curl -X POST -H "Authorization: Bearer $header" -H "Content-Type: application/x-www-form-urlencoded"  -d 'grant_type=password&username=admin&password=admin&validity_period=-1' "https://localhost:9443/oauth2/token" -k | jq -r '.access_token'`
echo "$response2"

