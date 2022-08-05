#! /bin/bash
CLUSTER_URL=$(kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server}')
CLUSTER_TOKEN=$(kubectl -n tap-gui get secret $(kubectl -n tap-gui get sa tap-gui-viewer -o=json \
| jq -r '.secrets[0].name') -o=json \
| jq -r '.data["token"]' \
| base64 --decode)
# Print out each cluster's details for manual copy and paste
echo $cluster "cluster URL:" $CLUSTER_URL
echo $cluster "cluster token:" $CLUSTER_TOKEN
