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
  String $redis_intranet_host,
  Array[String] $environment = [],
  String $traefik_rule = 'Host(`intranet.vision.fraunhofer.de`)||Host(`intranet.vision.fhg.de`)',
  String $intranet_tag = $facts['intranet_tag'],

) {

  contain ::vision_mysql::mariadb

  contain vision_intranet::config
  contain vision_intranet::database
  contain vision_intranet::docker

}
