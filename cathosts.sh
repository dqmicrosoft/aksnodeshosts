#/bin/bash


kubectl apply -f hosts-ds.yaml

echo "Pods are now being deployed"

while true
do

  ready=true

  for i in $(kubectl get pods | grep etc-hosts | grep -iv name | awk '{print $1}')
  do

    if [ $(kubectl get pod $i | grep -iv status | awk '{print $3}') != "Running" ]
    then
      ready=false
    fi
  done


  if $creating; then break; fi
  
done

echo ""
echo "Returning /etc/hosts"

for i in $(kubectl get pods | grep etc-hosts | grep -iv name | awk '{print $1}')
do
  echo ""
  kubectl logs $i
  echo ""
done

kubectl delete ds etc-hosts







