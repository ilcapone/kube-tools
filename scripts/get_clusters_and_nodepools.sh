CommandClustersList='gcloud container clusters list --zone europe-west3 --project project-name'
ListClusters=`$CommandClustersList | awk 'NR != 1 {print $1}' `
for Cluster in $ListClusters
do
	echo $Cluster
	export ClusterName=$Cluster
	CommandNodePool='gcloud container node-pools list --zone europe-west3 --cluster '$ClusterName'  --project projectname'
	ListNodePools=`$CommandNodePool | awk 'NR != 1 {print $1}' `
	for NodePool in $ListNodePools; do echo $NodePool; done
done
