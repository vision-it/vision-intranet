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
# contain ::vision_intranet::config_beta
#

class vision_intranet::config_beta (

) {

  contain ::vision_jenkins::user

  vision_shipit::inotify { 'intranet_5_tag':
    group   => 'jenkins',
    require => Class['::vision_jenkins::user'],
  }

  file {
    [
      '/opt/intranet5',
      '/opt/intranet5/storage'
    ]:
    ensure => directory,
    owner  => 'www-data',
    group  => 'www-data',
  }

}
