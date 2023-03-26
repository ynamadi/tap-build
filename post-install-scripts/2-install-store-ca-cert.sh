#! /bin/bash
VIEW_CLUSTER="tap-gui"
BUILD_CLUSTER="tap-build"

#Set context to view cluster
kubectx $VIEW_CLUSTER

#Retrieve Metadata Store CA Cert
CA_CERT=$(kubectl get secret -n metadata-store ingress-cert -o json | jq -r ".data.\"ca.crt\"")
echo "CA_CERT: $CA_CERT"
#Retrieve Supply Chain Security Tools - Store’s Auth token
AUTH_TOKEN=$(kubectl get secrets metadata-store-read-write-client -n metadata-store -o jsonpath="{.data.token}" | base64 -d)
echo "AUTH_TOKEN: $AUTH_TOKEN"
#Set context to Build cluster
kubectx $BUILD_CLUSTER

# Create secrets namespace
kubectl create ns metadata-store-secrets

# Create the CA Certificate secret
cat <<EOF | kubectl create -f -
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: store-ca-cert
  namespace: metadata-store-secrets
data:
  ca.crt: $CA_CERT
EOF

kubectl create secret generic store-auth-token \
  --from-literal=auth_token=$AUTH_TOKEN -n metadata-store-secrets