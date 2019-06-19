CommandNodePool='gcloud container node-pools list --zone europe-west3 --cluster cluster-name --project project-name'
ListNodePools=`$CommandNodePool | awk 'NR != 1 {print $1}' `
for NodePool in $ListNodePools; do echo $NodePool; done
