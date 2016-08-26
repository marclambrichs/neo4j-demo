# neo4j test environment using vagrant

## Requirements

	virtualbox => https://www.virtualbox.org/
	vagrant    => https://www.vagrantup.com/

## Setup

	git submodule update --init

## Environments

### Single
1 node => neo4j community edition

	cd vagrant/single
	vagrant up

### HA
3 nodes => neo4j enterprise edition

	cd vagrant/ha
	vagrant up
