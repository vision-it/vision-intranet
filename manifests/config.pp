# Class: vision_intranet::config
# ===========================
#
# Parameters
# ----------
#
# Examples
# --------
#
# @example
# contain ::vision_intranet::config
#

class vision_intranet::config (

) {

  contain ::vision_jenkins::user

  vision_shipit::inotify { 'intranet_tag':
    group   => 'jenkins',
    require => Class['::vision_jenkins::user'],
  }

  file {
    [
      '/opt/intranet',
      '/opt/intranet/storage'
    ]:
    ensure => directory,
    owner  => 'www-data',
    group  => 'www-data',
  }

  file { '/usr/local/sbin/sync-intranet.sh':
    ensure  => present,
    owner   => 'root',
    mode    => '0750',
    content => template('vision_intranet/sync-intranet.sh.erb'),
  }

}
