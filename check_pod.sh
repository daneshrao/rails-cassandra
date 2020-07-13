#!/bin/bash
#source ~/.bashrc
#kubectl -n default patch hpa rails-app --patch '{"spec":{"maxReplicas":1}}'
sleep 30
pod_id=$(kubectl get pods|grep rails-app|awk '{if($2 == "0/1"||$3 == "Running"||$3 == "ContainerCreating")print $1}'|head -n 1)
echo $pod_id
while true; do
status=$(kubectl get pods|grep "$pod_id"|awk '{if($2 == "0/1" && $3 == "Error" || $3 == "CrashLoopBackOff"|| $3 == "ImagePullBackOff")print $3}')
echo $status
success_status=$(kubectl get pods|grep "$pod_id"|awk '{if($2 == "1/1" && $3 == "Running")print $3}') 
echo "Status is $success_status"
if [ "$status" = "Error" ] || [ "$status" = "CrashLoopBackOff" ] || [ "$status" = "ImagePullBackOff" ]
then 
echo "status is $status"
exit 1 
elif [ "$success_status" = "Running" ]
then
echo "status is $success_status"
#kubectl -n default patch hpa rails-app --patch '{"spec":{"maxReplicas":10}}'
exit 0
fi
sleep 10
done
