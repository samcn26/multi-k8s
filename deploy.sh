# build all images and push to your account here
docker build -t samcn26/multi-client:latest -t samcn26/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t samcn26/multi-server:latest -t samcn26/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t samcn26/multi-worker:latest -t samcn26/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push samcn26/multi-client:latest
docker push samcn26/multi-server:latest
docker push samcn26/multi-worker:latest
docker push samcn26/multi-client:$SHA
docker push samcn26/multi-server:$SHA
docker push samcn26/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployment/server-deployment server=samcn26/multi-server:$SHA
kubectl set image deployment/worker-deployment worker=samcn26/multi-worker:$SHA
kubectl set image deployment/client-deployment client=samcn26/multi-client:$SHA