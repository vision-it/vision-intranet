# Class: vision_intranet
# ===========================
#
# Parameters
# ----------
#
# Examples
# --------
#
# @example
# contain ::vision_intranet
#

class vision_intranet (

  String $mysql_root_password,
  String $mysql_monitoring_password,
  String $mysql_backup_password,
  String $mysql_intranet_database,
  String $mysql_intranet_user,
  String $mysql_intranet_password,
  Array  $docker_volumes = []

) {

  contain ::vision_docker
  contain ::vision_jenkins::user
  contain vision_intranet::docker
  contain vision_intranet::database

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

  Class['::vision_docker']
  -> Class['::vision_intranet::database']
  -> Class['::vision_intranet::docker']

}
