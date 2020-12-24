docker build -t danielofir/multi-client:latest -t danielofir/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t danielofir/multi-server:latest -t danielofir/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t danielofir/multi-worker:latest -t danielofir/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push danielofir/multi-client:latest
docker push danielofir/multi-server:latest
docker push danielofir/multi-worker:latest

docker push danielofir/multi-server:$SHA
docker push danielofir/multi-client:$SHA
docker push danielofir/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=danielofir/multi-server:$SHA
kubectl set image deployments/client-deployment client=danielofir/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=danielofir/multi-worker:$SHA

