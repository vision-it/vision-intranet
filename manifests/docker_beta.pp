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

class vision_intranet::docker_beta (

  String $mysql_intranet_database   = $vision_intranet::beta::mysql_intranet_database,
  String $mysql_intranet_user       = $vision_intranet::beta::mysql_intranet_user,
  String $mysql_intranet_password   = $vision_intranet::beta::mysql_intranet_password,
  Array[String] $docker_volumes     = $vision_intranet::beta::docker_volumes,
  Array[String] $environment        = $vision_intranet::beta::environment,
  Integer $port                     = $vision_intranet::beta::port,

) {

  contain ::vision_docker

  if ($facts['intranet_5_tag'] == undef) {
    $intranet_tag = 'latest'
    } else {
      $intranet_tag = $facts['intranet_5_tag']
  }

  ::docker::image { 'intranet-laravel-5':
    ensure    => present,
    image     => 'vision.fraunhofer.de/intranet-laravel-5',
    image_tag => $intranet_tag,
    require   => Class['vision_docker']
  }

  $docker_environment = concat([
      "DB_HOST=${::fqdn}",
      "DB_DATABASE=${mysql_intranet_database}",
      "DB_USERNAME=${mysql_intranet_user}",
      "DB_PASSWORD=${mysql_intranet_password}",
  ], $environment)

  ::docker::run { 'intranet-laravel-5':
    image   => "vision.fraunhofer.de/intranet-laravel-5:${intranet_tag}",
    env     => $docker_environment,
    ports   => [ "${port}:80" ],
    volumes => $docker_volumes
  }

}
