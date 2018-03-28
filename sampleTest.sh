#!/bin/bash

kubernetes_sample_dir="/Users/anuruddha/Repos/ballerinax/kubernetes/samples/"
docker_sample_dir="/Users/anuruddha/Repos/ballerinax/docker/samples/"
# export PATH=/Users/anuruddha/Desktop/workspace/ballerina-tools-0.964.1-SNAPSHOT/bin:"$PATH"
export DOCKER_USERNAME=anuruddhal
export DOCKER_PASSWORD=1qaz2wsx@

for number in {1..9}
do
	echo "======================== Testing sample-$number ========================"
	pushd "$kubernetes_sample_dir"sample"$number"
	if [[ number -eq 1 ]]; then
		ballerina build hello_world_k8s.bal
		kubectl apply -f ./kubernetes
		port=$(kubectl get svc helloworldep-svc -o go-template='{{range.spec.ports}}{{if .nodePort}}{{.nodePort}}{{"\n"}}{{end}}{{end}}')
		sleep 5
		curl http://localhost:$port/HelloWorld/sayHello
		kubectl delete -f ./kubernetes
	fi
	if [[ number -eq 2 ]]; then
		ballerina build hello_world_k8s_config.bal
		kubectl apply -f ./kubernetes
		sleep 5
		curl http://abc.com/HelloWorld/sayHello
		kubectl delete -f ./kubernetes
	fi
	if [[ number -eq 3 ]]; then
		ballerina build pizzashack.bal
		kubectl apply -f ./kubernetes
		sleep 5
		curl http://order.com/orders
		curl http://pizzashack.com/customer		
		kubectl delete -f ./kubernetes
	fi

	if [[ number -eq 4 ]]; then
		ballerina build foodstore.bal
		kubectl apply -f ./kubernetes
		sleep 5
		curl http://pizza.com/pizzastore/pizza/menu		
		curl http://burger.com/menu		
		kubectl delete -f ./kubernetes
	fi

	if [[ number -eq 5 ]]; then
		ballerina build hello_world_gce.bal
		kubectl apply -f ./kubernetes
		sleep 5
		curl http://abc.com/helloWorld/sayHello
		kubectl delete -f ./kubernetes
	fi

	if [[ number -eq 6 ]]; then
		ballerina build hello_world_ssl_k8s.bal.bal
		kubectl apply -f ./kubernetes
		sleep 5
		curl https://abc.com/helloWorld/sayHello -k		
		kubectl delete -f ./kubernetes
	fi

	if [[ number -eq 7 ]]; then
		ballerina build hello_world_secret_mount_k8s.bal
		kubectl apply -f ./kubernetes
		sleep 5
		curl https://abc.com/helloWorld/secret1 -k		
		curl https://abc.com/helloWorld/secret2 -k		
		curl https://abc.com/helloWorld/secret3 -k
		
		kubectl delete -f ./kubernetes
	fi

	if [[ number -eq 8 ]]; then
		ballerina build hello_world_config_map_k8s.bal
		kubectl apply -f ./kubernetes
		sleep 5
		curl https://abc.com/helloWorld/config/john -k
		curl https://abc.com/helloWorld/config/jane -k
		kubectl delete -f ./kubernetes
	fi
	
	if [[ number -eq 9 ]]; then
		ballerina build hello_world_persistence_volume_k8s.bal
		kubectl apply -f ./kubernetes
		sleep 10
		curl https://abc.com/helloWorld/sayHello -k		
		kubectl delete -f ./kubernetes
	fi
	echo "======================== End of sample-$number ========================"
	popd
done

for number in {1..4}
do
	echo "======================== Testing sample-$number ========================"
	pushd "$docker_sample_dir"sample"$number"
	if [[ number -eq 1 ]]; then
		ballerina build hello_world_docker.bal
		dockerId=$(docker run -d -p 9090:9090 hello_world_docker:latest)
		sleep 2
		curl http://localhost:9090/HelloWorld/sayHello
		docker kill $dockerId
	fi
	
	if [[ number -eq 2 ]]; then
		ballerina build hello_world_docker.bal
		dockerId=$(docker run -d -p 9090:9090 docker.abc.com/helloworld:v1.0)
		sleep 2
		curl http://localhost:9090/HelloWorld/sayHello
		docker kill $dockerId
	fi

	if [[ number -eq 3 ]]; then
		ballerina build docker_push_sample.bal
		dockerId=$(docker run -d -p 9090:9090 index.docker.io/anuruddhal/helloworld-push:v2.0.0)
		sleep 2
		curl http://localhost:9090/HelloWorld/sayHello
		docker kill $dockerId
	fi

	if [[ number -eq 4 ]]; then
		ballerina build docker_debug.bal
		dockerId=$(docker run -d -p 9090:9090 -p 5005:5005 helloworld-debug:latest)
		sleep 2
		docker logs $dockerId
		docker kill $dockerId
	fi
	echo "======================== End of sample-$number ========================"

	popd
done		


exit 0