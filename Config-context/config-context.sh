IpAdres=$1
port=$2
clustername=$3
clusterCAPath=$4
username=$5
userPathCert=$6
userPathKey=$7
contextname=$8
# Config new cluster
kubectl config set-cluster $clustername --server=https://$IpAdres:$port --certificate-authority=$clusterCAPath
# Config user credentials
kubectl config set-credentials $username  --client-certificate=$userPathCert --client-key=$userPathKey
# Config context
kubectl config set-context $contextname --cluster=$clustername --user=$username
# Select new context
kubectl config use-context $contextname
