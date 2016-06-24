#!/bin/bash
ssh-add ck_workshop.pem
./run.py --no-confirm --verbose --cluster-id $cluser_id --num-nodes $num_nodes \
--num-infra 1 --master-instance-type $master_type --infra-instance-type $infra_type \
--node-instance-type $node_type --run-smoke-tests --num-smoke-test-users $users_count \
--keypair ck_workshop --r53-zone ck.osecloud.com --rhsm-user $rhsm_user \
--console-port 443 --api-port 443 \
--rhsm-pass $rhsm_pass --region us-west-2 --ami ami-775e4f16
