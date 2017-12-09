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

  String $phpmyadmin_server,
  String $mysql_root_password,
  String $mysql_monitoring_password,
  String $mysql_backup_password,
  String $mysql_intranet_database,
  String $mysql_intranet_user,
  String $mysql_intranet_password

) {

  contain ::vision_docker
  contain vision_intranet::beanstalk
  contain vision_intranet::docker
  contain vision_intranet::database

  file { ['/opt/intranet', '/opt/intranet/storage']:
    ensure => directory,
  }

  Class['::vision_docker']
  -> Class['::vision_intranet::database']
  -> Class['::vision_intranet::docker']

}
