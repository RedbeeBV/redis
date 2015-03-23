define redis::instance(
  $ip_address = '0.0.0.0',
  $port = '6379',
  $ensure = running,
  $enable = true,
  $slaveof = undef,
  ) {

    file { "/var/lib/redis-${title}/":
      ensure => directory,
    }

    file { "/etc/redis-${title}.conf":
      content => template("redis/redis.erb")
    }

    file { "/etc/systemd/system/redis-${title}.service":
      content => template("redis/redis.service.erb")
    }

    exec { 'reload systemd services':
      command => 'systemctl daemon-reload',
      path    => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    }

    service { "redis-${title}":
      ensure     => $ensure,
      enable     => $enable,
      hasrestart => true,
      hasstatus  => true,
    }

}
