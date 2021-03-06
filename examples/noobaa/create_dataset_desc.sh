#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# XXX http://s3.default.svc doesn't seem to work as the CSI provisioner seems
# to run in the host network namespace, so DNS doesn't resolve. Maybe it can
# still access the pod IPs though?
s3_url="http://$(kubectl get svc s3 -o json |jq -r .spec.clusterIP)"
# or http://localhost:$(kubectl get svc s3 -o json |jq .spec.ports[0].nodePort)

key_id=$(${DIR}/noobaa status 2>/dev/null | grep AWS_ACCESS_KEY_ID | awk -F ": " '{print $2}')
acc_key=$(${DIR}/noobaa status 2>/dev/null | grep AWS_SECRET_ACCESS_KEY | awk -F ": " '{print $2}')
bucket=$(${DIR}/noobaa bucket list 2>/dev/null | grep my-bucket | awk '{$1=$1};1')

sed -e "s|{AWS_ACCESS_KEY_ID}|${key_id}|g" \
	-e "s|{AWS_SECRET_ACCESS_KEY}|${acc_key}|g" \
	-e "s|{BUCKET_NAME}|${bucket}|g" \
	-e "s|{S3_SERVICE_URL}|${s3_url}|g"\
	${DIR}/../templates/example-dataset-s3.yaml > ${DIR}/dataset-noobaa.yaml
