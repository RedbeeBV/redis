define redis::sentinel(
  $dir = '/tmp',
  $port = '26379',
  $ensure = running,
  $enable = true,
  $monitors = {},
  ) {

    file { "/var/lib/redis-sentinel-${title}":
      ensure => directory,
    }

    file { "/etc/redis-sentinel-${title}.conf":
      content => template('redis/sentinel.erb')
    }

    file { "/etc/systemd/system/redis-sentinel-${title}.service":
      content => template('redis/sentinel.service.erb')
    }

    exec { 'reload systemd services':
      command => 'systemctl daemon-reload',
      path    => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    }

    service { "redis-sentinel-${title}":
      ensure     => ensure,
      enable     => enable,
      hasrestart => true,
      hasstatus  => true,
    }

}
