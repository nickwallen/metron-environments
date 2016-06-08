# Apache Metron

The goal of this project is to show how the configuration of an Apache Metron environment might be managed separately from the Apache Metron source code itself.  Currently, all deployment examples only show how to configure and deploy when the configuration artifacts are embedded within the Apache Metron source code itself.  Maintaining these artifacts external to the source code is necessary for keeping up-to-date with changes in Apache Metron.

## Usage

(1) Define an environment variable that points to where the source code for Apache Metron is located.

```
export METRON_HOME=~/Development/incubator-metron
```

(2) Create a new working directory following the example of `metron-dev` for each separate environment that Metron needs deployed to.  For example, you might maintain separate Dev, QA, and Production environments.

(3) Edit `ansible.cfg` to enable connectivity to your target environment.  This might require specifying the path to a different SSH key or a different user account.

(4) Run the validation script to validate connectivity to the test environment.  If connectivity fails, you probably need to tweak `ansible.cfg`.

```
./validate.sh metron-dev
```

(5) Deploy Metron to the target environment.

```
./run.sh metron-dev
```

## Testing

To create an environment in AWS that can be used for testing these scripts, run the following command to lay down an environment with HDP, Elasticsearch, and MySQL that is ready to install Metron.

```
cd metron-deployments/amazon-ec2
export EC2_INI_PATH=conf/ec2.ini
ansible-playbook -i ec2.py playbook.yml \
  --tags="ec2,ambari,elasticsearch,mysql-server,mysql-client" \
  --extra-vars="env=my-metron-env"
```
