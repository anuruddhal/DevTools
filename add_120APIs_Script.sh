
#file : wso2am-1.8.0 ▸ repository ▸ deployment ▸ server ▸ jaggeryapps ▸ store ▸ site ▸ themes ▸ fancy ▸ templates ▸ api ▸ api-listing-all - template.jag

# add 50 apis having regx name *callservice*
commonRegx1="callservice"
portNumber=9763
username=admin@t1.com
password=admin123

curl -X POST -c cookies http://localhost:"$portNumber"/publisher/site/blocks/user/login/ajax/login.jag -d "action=login&username=$username&password=$password"

for i in {1..20}
do
	nameOfAPI=$commonRegx1$i
	curl -X POST -b cookies http://localhost:"$portNumber"/publisher/site/blocks/item-add/ajax/add.jag -d "action=addAPI&name="$nameOfAPI"&context="/$nameOfAPI"&version=1.0.0&visibility=public&description=Verify a phone number&tags=phone&endpointType=nonsecured&tiersCollection=Gold,Bronze&http_checked=http&https_checked=https&resourceCount=0&resourceMethod-0=GET&resourceMethodAuthType-0=Application&resourceMethodThrottlingTier-0=Unlimited&uriTemplate-0=/*&default_version_checked=default_version&bizOwner=xx&bizOwnerMail=xx@ee.com&techOwner=xx&techOwnerMail=ggg@ww.com" -d 'endpoint_config={"production_endpoints":{"url":"http://ws.cdyne.com/phoneverify/phoneverify.asmx","config":null},"endpoint_type":"http "}';
	sleep 0.05
	curl -X POST -b cookies 'http://localhost:'$portNumber'/publisher/site/blocks/life-cycles/ajax/life-cycles.jag' -d 'action=updateStatus&name='$nameOfAPI'&version=1.0.0&provider='$username'&status=PUBLISHED&publishToGateway=true&requireResubscription=true'	
	sleep 0.05
done
############################################################################################################################



# add 50 apis having regx name *financial*
# commonRegx2="financial"
# tags='phone,mobile'
# for i in {1..20}
# do
# 	nameOfAPI=$commonRegx2$i
# 	curl -X POST -b cookies http://localhost:"$portNumber"/publisher/site/blocks/item-add/ajax/add.jag -d "action=addAPI&name="$nameOfAPI"&context="/$nameOfAPI"&version=1.0.0&visibility=public&description=Verify a phone number&tags=$tags&endpointType=nonsecured&tiersCollection=Gold,Bronze&http_checked=http&https_checked=https&resourceCount=0&resourceMethod-0=GET&resourceMethodAuthType-0=Application&resourceMethodThrottlingTier-0=Unlimited&uriTemplate-0=/*&default_version_checked=default_version&bizOwner=xx&bizOwnerMail=xx@ee.com&techOwner=xx&techOwnerMail=ggg@ww.com" -d 'endpoint_config={"production_endpoints":{"url":"http://ws.cdyne.com/phoneverify/phoneverify.asmx","config":null},"endpoint_type":"http "}';
# 	sleep 0.05
# 	curl -X POST -b cookies 'http://localhost:'$portNumber'/publisher/site/blocks/life-cycles/ajax/life-cycles.jag' -d 'action=updateStatus&name='$nameOfAPI'&version=1.0.0&provider='$username'&status=PUBLISHED&publishToGateway=true&requireResubscription=true'	
# 	sleep 0.05
# done
# ############################################################################################################################
# 
# add 16 apis having regx name *ucsc*
# commonRegx3="ucsc"
# 
# for i in {1..20}
# do
# 	nameOfAPI=$commonRegx3$i
# 	curl -X POST -b cookies http://localhost:"$portNumber"/publisher/site/blocks/item-add/ajax/add.jag -d "action=addAPI&name="$nameOfAPI"&context="/$nameOfAPI"&version=1.0.0&visibility=public&description=Verify a phone number&tags=phone,mobile,multimedia&endpointType=nonsecured&tiersCollection=Gold,Bronze&http_checked=http&https_checked=https&resourceCount=0&resourceMethod-0=GET&resourceMethodAuthType-0=Application&resourceMethodThrottlingTier-0=Unlimited&uriTemplate-0=/*&default_version_checked=default_version&bizOwner=xx&bizOwnerMail=xx@ee.com&techOwner=xx&techOwnerMail=ggg@ww.com" -d 'endpoint_config={"production_endpoints":{"url":"http://ws.cdyne.com/phoneverify/phoneverify.asmx","config":null},"endpoint_type":"http "}';
# 	sleep 0.05
# 	curl -X POST -b cookies 'http://localhost:'$portNumber'/publisher/site/blocks/life-cycles/ajax/life-cycles.jag' -d 'action=updateStatus&name='$nameOfAPI'&version=1.0.0&provider='$username'&status=PUBLISHED&publishToGateway=true&requireResubscription=true'	
# 	sleep 0.05
# done
# ############################################################################################################################
# 
# add 21 apis having regx name *srilanka*
# commonRegx4="srilanka"
# 
# for i in {1..20}
# do
# 	nameOfAPI=$commonRegx4$i
# 	curl -X POST -b cookies http://localhost:"$portNumber"/publisher/site/blocks/item-add/ajax/add.jag -d "action=addAPI&name="$nameOfAPI"&context="/$nameOfAPI"&version=1.0.0&visibility=public&description=Verify a phone number&tags=phone,mobile,multimedia&endpointType=nonsecured&tiersCollection=Gold,Bronze&http_checked=http&https_checked=https&resourceCount=0&resourceMethod-0=GET&resourceMethodAuthType-0=Application&resourceMethodThrottlingTier-0=Unlimited&uriTemplate-0=/*&default_version_checked=default_version&bizOwner=xx&bizOwnerMail=xx@ee.com&techOwner=xx&techOwnerMail=ggg@ww.com" -d 'endpoint_config={"production_endpoints":{"url":"http://ws.cdyne.com/phoneverify/phoneverify.asmx","config":null},"endpoint_type":"http "}';
#     sleep 0.05
# 	curl -X POST -b cookies 'http://localhost:'$portNumber'/publisher/site/blocks/life-cycles/ajax/life-cycles.jag' -d 'action=updateStatus&name='$nameOfAPI'&version=1.0.0&provider='$username'&status=PUBLISHED&publishToGateway=true&requireResubscription=true'	
#     sleep 0.05
# done


curl -b cookies http://localhost:"$portNumber"/publisher/site/blocks/user/login/ajax/login.jag?action=logout

#remove temp cookie file
rm -r cookies
