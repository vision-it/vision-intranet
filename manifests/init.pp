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
  String $mysql_backup_password     = hiera('intranet::database::backup_password'),
  String $mysql_intranet_database   = hiera('intranet::database::name'),
  String $mysql_intranet_password   = hiera('intranet::database::password'),
  String $mysql_intranet_user       = hiera('intranet::database::user'),
  String $mysql_monitoring_password = hiera('intranet::database::monitoring_password'),
  String $mysql_root_password       = hiera('intranet::database::root_password'),

) {

  contain vision_intranet::beanstalk
  contain vision_intranet::docker
  contain vision_intranet::database

  file { ['/opt/intranet', '/opt/intranet/storage']:
    ensure => directory,
  }


}
