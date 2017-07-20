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

  String $mysql_root_password = hiera('intranet::database::root_password'),
  String $mysql_monitoring_password = hiera('intranet::database::monitoring_password'),
  String $mysql_backup_password = hiera('intranet::database::backup_password'),

  String $mysql_adressen_database = hiera('intranet::database::adressen::name'),
  String $mysql_adressen_user = hiera('intranet::database::adressen::user'),
  String $mysql_adressen_password = hiera('intranet::database::adressen::password'),

  String $mysql_projekte_database = hiera('intranet::database::projekte::name'),
  String $mysql_projekte_user = hiera('intranet::database::projekte::user'),
  String $mysql_projekte_password = hiera('intranet::database::projekte::password'),

  String $mysql_voruntersuchungen_database = hiera('intranet::database::voruntersuchungen::name'),
  String $mysql_voruntersuchungen_user = hiera('intranet::database::voruntersuchungen::user'),
  String $mysql_voruntersuchungen_password = hiera('intranet::database::voruntersuchungen::password'),

  String $mysql_presse_database = hiera('intranet::database::presse::name'),
  String $mysql_presse_user = hiera('intranet::database::presse::user'),
  String $mysql_presse_password = hiera('intranet::database::presse::password'),

  String $mysql_intranet_database = hiera('intranet::database::name'),
  String $mysql_intranet_user = hiera('intranet::database::user'),
  String $mysql_intranet_password = hiera('intranet::database::password'),


) {

  contain vision_intranet::beanstalk
  contain vision_intranet::docker
  contain vision_intranet::database

  file { ['/opt/intranet', '/opt/intranet/storage']:
    ensure => directory,
  }


}
