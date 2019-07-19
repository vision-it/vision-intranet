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

  String $mysql_intranet_database   = $vision_intranet::mysql_intranet_database,
  String $mysql_intranet_user       = $vision_intranet::mysql_intranet_user,
  String $mysql_intranet_password   = $vision_intranet::mysql_intranet_password,
  Array[String] $docker_volumes     = $vision_intranet::docker_volumes,
  Array[String] $environment        = $vision_intranet::environment,
  Integer $port                     = $vision_intranet::port,

) {

  contain ::vision_docker

  if ($facts['intranet_tag'] == undef) {
    $intranet_tag = 'latest'
    } else {
      $intranet_tag = $facts['intranet_tag']
  }

  ::docker::image { 'intranet':
    ensure    => present,
    image     => 'registry.gitlab.cc-asp.fraunhofer.de:4567/vision-it/application/intranet',
    image_tag => $intranet_tag,
    require   => Class['vision_docker']
  }

  $docker_environment = concat([
      "DB_HOST=${::fqdn}",
      "DB_DATABASE=${mysql_intranet_database}",
      "DB_USERNAME=${mysql_intranet_user}",
      "DB_PASSWORD=${mysql_intranet_password}",
  ], $environment)

  ::docker::run { 'intranet':
    image   => "registry.gitlab.cc-asp.fraunhofer.de:4567/vision-it/application/intranet:${intranet_tag}",
    env     => $docker_environment,
    ports   => [ "${port}:8080" ],
    volumes => $docker_volumes
  }

}
