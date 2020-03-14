# helm-charts.

## Team Information

| Name | NEU ID | Email Address |
| --- | --- | --- |
| Akash Katakam | 001400025 | katakam.a@husky.neu.edu |
| Ravi Kiran    | 001439467 | lnu.ra@husky.neu.edu |
| Veena Iyer    | 001447061  | iyer.v@husky.neu.edu|

## Prerequisite
Kubernetes Cluster, Amazon Account with programatic access and full s3 access
Make sure you have helm installed locally from `https://helm.sh/docs/intro/quickstart/#install-helm`

## To run this helm chart
Create a namespace for backend and frontend application with any name like below
```
kubectl create ns api/ui
```
Following values are configurable in values.yaml or can be passed with --set flag
```sh

## Values are required for below fields and cannot be daulted
aws:
  bucketName: 
  accessKeyId:
  secretAccessKey:

## Run the helm chart with your values
```sh
helm install v1 helm-backend/ 
--set replicaset.backend_image=<DOCKERIMAGE> --set database.url=<RDS URL created by clusters> --set database.user=<DB user> 
--set database.password=<DB Password> --set namespace.name=<NS created> --set imageCredentials.username=<DOCKER username> 
--set imageCredentials.password=<DOCKER password> --set s3.accesskey=<AWS ACCESS> --set s3.secretkey=<AWS SECRET>

helm install v5 helm-frontend/ --set namespace.name=<NS created>,replicaset.frontend_image=<DOCKERIMAGE>,
imageCredentials.username=<DOCKER username> ,imageCredentials.password=<DOCKER password> ,replicaset.service_name=<BACKEND SERVICE NAME>,replicaset.backend_url=<BACKEND URL>
```
### Cleanup 

Delete the helm chart
```sh
helm del --purge CHARTNAME
``` 