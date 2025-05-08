#!/bin/bash 
echo ECS_CLUSTER=soop-dev-cluster >> /etc/ecs/ecs.config;

sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl restart sshd
echo '1234' | passwd --stdin ec2-user