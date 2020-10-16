echo " --- Cluster Info ---"
kubectl cluster-info
echo ""
echo " --- PODs ---"
kubectl get pods --namespace=$1
echo ""
echo " --- NODESs ---"
kubectl get nodes --namespace=$1
echo ""
echo " --- Services ---"
kubectl get services --namespace=$1
echo ""
echo " --- Deployments ---"
kubectl get deployment --namespace=$1
echo ""
echo " --- DeamonSet ---"
kubectl get ds --namespace=$1
echo ""
echo " --- Entry Points ---"
kubectl get ep --namespace=$1
echo ""
echo " --- Security Policies ---"
kubectl get psp --namespace=$1
echo ""
echo " --- Services Accounts ---"
kubectl get serviceAccounts --namespace=$1
echo ""
echo " --- Secrets ---"
kubectl get secret --namespace=$1
