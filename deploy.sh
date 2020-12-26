docker build -t danielofir/complex-client:latest -t danielofir/complex-client:$SHA -f ./client/Dockerfile ./client
docker build -t danielofir/complex-server:latest -t danielofir/complex-server:$SHA -f ./server/Dockerfile ./server
docker build -t danielofir/complex-worker:latest -t danielofir/complex-worker:$SHA -f ./worker/Dockerfile ./worker

docker push danielofir/complex-client:latest
docker push danielofir/complex-server:latest
docker push danielofir/complex-worker:latest

docker push danielofir/complex-client:$SHA
docker push danielofir/complex-server:$SHA
docker push danielofir/complex-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=danielofir/complex-client:$SHA
kubectl set image deployments/server-deployment server=danielofir/complex-server:$SHA
kubectl set image deployments/worker-deployment worker=danielofir/complex-worker:$SHA

