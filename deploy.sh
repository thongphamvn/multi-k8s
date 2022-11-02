docker build -t 290803/multi-client:latest -t 290803/multi-client:$SHA -f ./client/Dockerefile ./client
docker build -t 290803/multi-server:latest 290803/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t 290803/multi-worker:latest 290803/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push 290803/multi-client:latest
docker push 290803/multi-server:latest
docker push 290803/multi-worker:latest

docker push 290803/multi-client:$SHA
docker push 290803/multi-server:$SHA
docker push 290803/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=290803/multi-server:$SHA
kubectl set image deployments/client-deployment client=290803/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=290803/multi-worker:$SHA