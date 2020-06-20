docker build -t klisowski2016/multi-client:latest -t klisowski2016/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t klisowski2016/multi-server:latest -t klisowski2016/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t klisowski2016/multi-worker:latest -t klisowski2016/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push klisowski2016/multi-client:latest
docker push klisowski2016/multi-server:latest
docker push klisowski2016/multi-worker:latest
docker push klisowski2016/multi-client:$SHA
docker push klisowski2016/multi-server:$SHA
docker push klisowski2016/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=klisowski2016/multi-server:$SHA
kubectl set image deployments/client-deployment client=klisowski2016/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=klisowski2016/multi-worker:$SHA
