#!/usr/bin/env bash
#
# Validate connectivity to the working cluster.
#
# export METRON_HOME=~/Development/incubator-metron
# export METRON_SSH_KEY=~/.ssh/id_rsa.pub
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
ansible -i $INVENTORY_PATH all -m ping $EXTRA_ARGS
