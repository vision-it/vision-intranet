# Class: vision_intranet::docker
# ===========================
#
# Parameters
# ----------
#
# Examples
# --------
#
# @example
# contain ::vision_intranet::docker
#

class vision_intranet::docker (

  String $mysql_root_password       = $vision_intranet::mysql_root_password,
  String $mysql_monitoring_password = $vision_intranet::mysql_monitoring_password,
  String $mysql_backup_password     = $vision_intranet::mysql_backup_password,
  String $mysql_intranet_database   = $vision_intranet::mysql_intranet_database,
  String $mysql_intranet_user       = $vision_intranet::mysql_intranet_user,
  String $mysql_intranet_password   = $vision_intranet::mysql_intranet_password,
  Array  $docker_volumes            = $vision_intranet::docker_volumes,

) {

  ::docker::image { 'intranet':
    ensure    => present,
    image     => 'vision.fraunhofer.de/intranet',
    image_tag => 'latest',
  }

  ::docker::run { 'intranet':
    image   => 'vision.fraunhofer.de/intranet:latest',
    env     => [
      "DB_INTRANET_HOST=${::fqdn}",
      "DB_INTRANET_DATABASE=${mysql_intranet_database}",
      "DB_INTRANET_USERNAME=${mysql_intranet_user}",
      "DB_INTRANET_PASSWORD=${mysql_intranet_password}",
    ],
    ports   => [ '80:80' ],
    volumes => $docker_volumes
  }

}
