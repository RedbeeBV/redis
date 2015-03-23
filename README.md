# Redis

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Limitations - OS compatibility, etc.](#limitations)

## Overview

[![Build Status](https://travis-ci.org/RedbeeBV/redis.svg?branch=master)](https://travis-ci.org/RedbeeBV/redis)

Easy deployment of multiple redis or instances for systems that work with systemd.

## Module Description

This module can configure multiple redis or sentinel instances on one server for systems that work with systemd.

## Usage

```puppet
redis::instance { 'one':
  ip_address = '0.0.0.0',
  port = '6379',
  ensure = running,
  enable = true
}

redis::sentinel { 'cluster':
  dir = '/tmp',
  port = '26379',
  ensure = running,
  enable = true,
  monitors => {
    'master' => {
      master_host             => '127.0.0.1',
      master_port             => 6378,
      quorum                  => 2,
      down_after_milliseconds => 30000,
      parallel-syncs          => 1,
      failover_timeout        => 180000
    },
    'cluster' => {
      master_host             => '10.20.30.1',
      master_port             => 6379,
      quorum                  => 2,
      down_after_milliseconds => 30000,
      parallel-syncs          => 5,
      failover_timeout        => 180000,
      auth-pass => 'secret_Password',
      notification-script => '/tmp/notify.sh',
      client-reconfig-script => '/tmp/reconfig.sh'
    }
}
```

## Limitations

The systems need to be able to use systemd unit files. If not, this module will not work for you.
