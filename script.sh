docker build -t python-distroless:latest -f Dockerfile-distroless .
docker build -t python:latest -f Dockerfile-normal  .

trivy image python-distroless:latest
trivy image python:latest

docker run -d --name python-distroless-container -p 5001:5000 python-distroless:latest
docker run -d --name python-container -p 5002:5000 python:latest


# to debug normal image
docker exec -it python-container sh

# to debug distroless image
docker exec -it python-distroless-container sh  # this will not work as distroless image does not have shell

# will use cdebug to debug distroless image on docker 
cdebug exec -it --image=nixery.dev/shell/vim/ps/tshark/curl python-distroless-container

#  will use cdebug to debug distroless image on k8s
 cdebug exec --namespace=default --image=nixery.dev/shell/vim/ps/tshark/curl -it pod/<pod-name>

# to check which Ephermal container is running on k8s
kubectl describe pods/<pod-name>