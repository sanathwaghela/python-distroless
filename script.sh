docker build -t python-distroless:latest -f Dockerfile-distroless .
docker build -t python:latest -f Dockerfile-normal  .
docker build -t python-distroless:debug -f Dockerfile-distroless-debug .

trivy image python-distroless:latest
trivy image python:latest

docker run -d --name python-distroless-container -p 5001:5000 python-distroless:latest
docker run -d --name python-container -p 5002:5000 python:latest
docker run -d --name python-distroless-debug-container -p 5003:5000 python-distroless:debug


# to debug normal image
docker exec -it python-container sh

# to debug distroless image
docker exec -it python-distroless-container sh  # this will not work as distroless image does not have shell

# to debug distroless image with debug tag
docker exec -it python-distroless-debug-container sh

# will use cdebug to debug distroless image on docker 
cdebug exec -it --image=nixery.dev/shell/vim/ps/tshark/curl python-distroless-container

#  will use cdebug to debug distroless image on kubernetes
 cdebug exec --namespace=default --image=alpine -it pod/<pod-name>

#  will use kubectl to debug distroless image on kubernetes

kubectl debug -it podname --image=alpine --target=python-distroless

# to check which Ephermal container is running on k8s
kubectl describe pods/<pod-name>