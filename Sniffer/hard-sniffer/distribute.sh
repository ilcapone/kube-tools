#!/bin/bash
namespace=$1
filter_pod=$2
snif_time=$3
pod_list=$(kubectl get pods -n $namespace -o json | jq -r .items[].metadata.name)
echo "[*] Executing sn1f.sh in namespace: $namespace"
for pod in $pod_list
do
  if [[ $pod == *"$filter_pod"* ]]; then
      echo $pod
      kubectl cp sn1f.sh $pod:/home -n $namespace
      kubectl exec -i $pod -n $namespace -- nohup /home/sn1f.sh $pod &
      echo "- Injecting snffing"
      sleep 10
  fi
done
runtime="$snif_time minute"
endtime=$(date -ud "$runtime" +%s)
echo "[*] Extractng sniffing files during $runtime"
while [[ $(date -u +%s) -le $endtime ]]
do
    echo "- Time Now: `date +%H:%M:%S`"
    for pod in $pod_list
    do
      if [[ $pod == *"$filter_pod"* ]]; then
         echo "- Checking snif file in pod:  $pod"
         file_list=$(kubectl exec -it  -n $namespace $pod -- ls -l /home/ | awk '{ if ($5 >= 9999990) { print $9} }')
         for file in $file_list
         do
           file=$(echo $file | sed 's/\r$//')
           echo ">>> Etracting file $file"
           kubectl cp $file/$pod:/home/$file data/$file-$(date +"%s")
           sleep 5
           kubectl exec -it  -n $namespace $pod -- rm -rf $file
           sleep 5
         done
      fi
    done
    sleep 300 #5 mins
done
echo "[*] End sniffing!!"
