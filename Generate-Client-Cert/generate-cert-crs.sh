username=$1
group=$2
openssl genrsa -out $username.key 2048
openssl req -new -key $username.key -out $username.csr -subj "/CN=$username/O=$group"
echo "Send the $username.csr to the cluster administrator"
