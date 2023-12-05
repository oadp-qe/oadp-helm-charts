#!/bin/bash

readonly SCRIPT_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")

# Define the YAML file
YAML_FILE="${SCRIPT_DIR}/values.yaml"

# Define the new values for bucket and provider
NEW_BUCKET=$BUCKET

if [[ -z "$NEW_BUCKET" ]]; then
    echo "Bucket is not defined! Exit script..."
    exit 1
fi

NEW_PROVIDER=$(oc get infrastructures cluster -o jsonpath='{.status.platform}' | awk '{print tolower($0)}')

if [[ "$BACKUP_LOCATION_TYPE" == "MINIO" ]]; then
    NEW_S3_URL=$(oc get route minio -n minio -o jsonpath='{.spec.host}')
elif [[ "$BACKUP_LOCATION_TYPE" == "MCG" ]]; then
    NEW_S3_URL=$(oc get route s3 -n openshift-storage -o jsonpath='{.spec.host}')
fi

if [[ "$NEW_PROVIDER" ==  "openstack" ]]; then
    NEW_PROVIDER="aws"
fi

# Call Python script with arguments
python ${SCRIPT_DIR}/modify_yaml.py "$YAML_FILE" "$NEW_BUCKET" "$NEW_PROVIDER" "$NEW_S3_URL"
