# carbon_c_relay

[![Puppet Forge](http://img.shields.io/puppetforge/v/mlambrichs/carbon_c_relay.svg)](https://forge.puppetlabs.com/mlambrichs/carbon_c_relay) [![Build Status](https://travis-ci.org/mlambrichs/puppet-carbon_c_relay.svg?branch=master)](https://travis-ci.org/mlambrichs/puppet-carbon_c_relay)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with carbon_c_relay](#setup)
    * [Beginning with carbon_c_relay](#beginning-with-carbon_c_relay)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)
7. [Contributors - List of contributores to the module](#contributors)

## Overview

The carbon_c_relay puppet module installs, configures and manages a carbon-c-relay instance.

## Module Description

The carbon_c_relay module handles installing, configuring, and running carbon-c-relay.

## Setup

### Beginning with carbon_c_relay

`include '::carbon_c_relay` is enough to get you started. You can pass in parameters like this:

```puppet
class { '::carbon_c_relay':
  service_name => 'relay'
}
```

## Usage

## Reference

To see the inner workings of carbon-c-relay, take a look at
https://github.com/grobian/carbon-c-relay.git

## Limitations

## Development

## Contributors

https://github.com/mlambrichs/puppet-carbon_c_relay/graphs/contributors

