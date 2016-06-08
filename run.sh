#!/usr/bin/env bash
#
# Deploy Metron to the target environment.
#
#
INVENTORY_PATH=$1
if [ -z "$INVENTORY_PATH" ]; then
  echo "error: $0 [path-to-inventory-definition]"
  exit 1
fi

# ensure METRON_HOME is defined
if [ -z "$METRON_HOME" ]; then
  echo "Error: missing environment var: METRON_HOME"
  exit 1
fi

# ensure METRON_SSH_KEY is defined
if [ -z "$METRON_SSH_KEY" ]; then
  echo "Error: missing environment var: METRON_SSH_KEY"
  exit 1
fi

EXTRA_ARGS="${@:2}"
ansible-playbook \
      $METRON_HOME/metron-deployment/playbooks/metron_full_install.yml \
      --tags="metron-hbase,metron-kafka,enrichment,elasticsearch_templates" \
      -i $INVENTORY_PATH \
      $EXTRA_ARGS
