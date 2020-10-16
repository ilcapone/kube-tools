echo " --- Cluster Info ---"
kubectl cluster-info
echo ""
echo " --- PODs ---"
kubectl get pods --all-namespaces
echo ""
echo " --- NODESs ---"
kubectl get nodes --all-namespaces
echo ""
echo " --- Services ---"
kubectl get services --all-namespaces
echo ""
echo " --- Deployments ---"
kubectl get deployment --all-namespaces
echo ""
echo " --- DeamonSet ---"
kubectl get ds --all-namespaces
echo ""
echo " --- Deployments ---"
kubectl get deploymen --all-namespaces
echo ""
echo " --- Security Policies"
kubectl get psp --all-namespaces
echo ""
echo " --- Services Accounts ---"
kubectl get serviceAccounts --all-namespaces
echo ""
echo " -- Secrets ---"
kubectl get secret --all-namespaces
