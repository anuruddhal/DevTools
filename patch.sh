pushd $1
mvn clean install -Dmaven.test.skip=true
pushd ./target
mv *.jar $(ls *.jar| sed 's/-/_/')
mv *.jar $(ls *.jar| sed 's/-SNAPSHOT/\.SNAPSHOT/') 

mv  $1/target/*.jar /Users/anuruddha/Repos/product-apim/product/target/wso2apim-3.0.0-SNAPSHOT/wso2/lib/plugins
popd
