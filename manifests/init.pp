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

  String $mysql_intranet_database,
  String $mysql_intranet_user,
  String $mysql_intranet_password,
  Array  $docker_volumes = [],
  Integer $port = 80,
  Optional[String] $mysql_root_password,
  Optional[String] $mysql_backup_password,

) {

  contain vision_intranet::config
  contain vision_intranet::database
  contain vision_intranet::docker

}
