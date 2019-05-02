# Class: vision_intranet::beta
# ===========================
# Beta Version of new Intranet
#
# Parameters
# ----------
#
# Examples
# --------
#
# @example
# contain ::vision_intranet::beta
#

class vision_intranet::beta (

  String $mysql_intranet_database,
  String $mysql_intranet_user,
  String $mysql_intranet_password,
  String $mysql_root_password,
  Array[String] $docker_volumes = [],
  Array[String] $environment = [],
  Integer $port = 80,
  Optional[String] $mysql_backup_password = undef,

) {

  contain vision_intranet::config_beta
  contain vision_intranet::database_beta
  contain vision_intranet::docker_beta

}
