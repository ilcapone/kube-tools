echo " --- Cluster Info ---"
kubectl cluster-info
echo ""
echo " --- PODs ---"
kubectl get pods
echo ""
echo " --- NODESs ---"
kubectl get nodes
echo ""
echo " --- Services ---"
kubectl get services
echo ""
echo " --- Deployments ---"
kubectl get deployment
echo ""
echo " --- DeamonSet ---"
kubectl get ds
echo ""
echo " --- Entry Points ---"
kubectl get ep
echo ""
echo " --- Security Policies ---"
kubectl get psp
echo ""
echo " --- Services Accounts ---"
kubectl get serviceAccounts
echo ""
echo " --- Secrets ---"
kubectl get secret
