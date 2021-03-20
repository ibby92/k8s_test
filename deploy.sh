docker build -t ibbyh92/multi-client:latest -t ibbyh92/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ibbyh92/multi-server:latest -t ibbyh92/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ibbyh92/multi-worker:latest -t ibbyh92/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ibbyh92/multi-client:latest
docker push ibbyh92/multi-server:latest
docker push ibbyh92/multi-worker:latest

docker push ibbyh92/multi-client:$SHA
docker push ibbyh92/multi-server:$SHA
docker push ibbyh92/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ibbyh92/multi-server:$SHA
kubectl set image deployments/client-deployment client=ibbyh92/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ibbyh92/multi-worker:$SHA