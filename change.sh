#!/bin/bash
image_id=$1
echo "$image_id"
#sed -i -e"s/753634426646.dkr.ecr.us-east-1.amazonaws.com\/aes_dev_app_non-prod.*/753634426646.dkr.ecr.us-east-1.amazonaws.com\/aes_dev_app_non-prod:$ver_no/g" aes_deployment.yaml
#sed -i -e"s/878737446932.dkr.ecr.us-east-2.amazonaws.com\/aes_db.*/878737446932.dkr.ecr.us-east-2.amazonaws.com\/aes_db:$ver_no/g" aes_deployment.yaml
#cat aes_deployment.yaml
#sudo kubectl get svc
template=`cat rails-app.yaml | sed "s#{{$DOCKER_IMAGE_NAME:$BUILD_NUMBER}}#$image_id#"`

echo "$template" | kubectl apply -f -

#source ~/.bashrc
kubectl apply -f rails-app.yaml --record


