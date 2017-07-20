# Simple beanstalkd installation for Debian
#
class vision_intranet::beanstalk {

  $listen_addr      = '127.0.0.1'
  $listen_port      = '11300'
  $enable_binlog    = false
  $package_ensure   = 'present'
  $service_ensure   = 'running'
  $service_enable   = true
  $max_job_size     = '65535'

  $service_start_yes = true
  $daemon_options    = false
  $service_provider  = 'systemd'

  $binlog_directory = '/var/lib/beanstalkd'
  $config           = '/etc/default/beanstalkd'
  $config_template  = 'vision_intranet/beanstalkd.debian.erb'
  $package_name     = 'beanstalkd'
  $user             = 'beanstalkd'
  $group            = 'beanstalkd'

  package { $package_name:
    ensure => $package_ensure,
  }
  -> file { $config:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($config_template),
  }
  -> file { $binlog_directory:
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0644',
  }
  -> service { 'beanstalkd':
    ensure     => $service_ensure,
    enable     => $service_enable,
    provider   => $service_provider,
    hasstatus  => true,
    hasrestart => true,
  }

}
