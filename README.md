# Confluent's Zookeeper and Kafka

## Inventory
Modify inventory file in production or staging folder

> [zookeeper]

> public_ip_1

> public_ip_2

> public_ip_3

That config format will create zookeeper's quorum automatically.
You can add more server like public_ip_4 public_ip_5

> [zookeeper:vars]

> ansible_ssh_private_key_file=~/.ssh/pem_key

> ansible_pkg_mgr='apt'

ansible_ssh_private_key_file can be used for ssh key or pem key for

ansible_pkg_mgr var can be used for apt or yum. For yum need to be add install.yum.yml in common tasks.

## Provisioning by ansible-playbook
There're playbooks of zookeeper and kafka

> zookeeper-setup.yml

> zookeeper-restart.yml

> kafka-server-setup.yml

> kafka-server-restart.yml

1. setup : Install java, confluent platform by common tasks.

2. restart : Run zookeeper or kafka as a service on every host

> ansible-playbook -i staging|production/inventory play_book_name.yml

## Provisioning by bash script jenkinsbuild.sh

It's just a bash script for the simplest jenkins job. Just read jenkinsbuild.sh for more detail.
