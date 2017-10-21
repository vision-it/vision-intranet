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
  String $mysql_intranet_password   = $vision_intranet::mysql_intranet_password,
  String $mysql_intranet_user       = $vision_intranet::mysql_intranet_user,

) {

  contain ::vision_docker

  ::docker::image { 'intranet':
    ensure    => present,
    image     => 'vision.fraunhofer.de/intranet',
    image_tag => 'latest',
  }

  ::docker::run { 'intranet':
    image   => 'vision.fraunhofer.de/intranet:lastest',
    env     => [
      "DB_INTRANET_HOST=${::fqdn}",
      "DB_INTRANET_DATABASE=${mysql_intranet_database}",
      "DB_INTRANET_USERNAME=${mysql_intranet_user}",
      "DB_INTRANET_PASSWORD=${mysql_intranet_password}",
    ],
    ports   => [ '80:80' ],
    volumes => [
      '/opt/intranet/storage/old:/var/www/html/app/storage/old',
      '/opt/intranet/storage/logs:/var/www/html/app/storage/logs',
      '/opt/intranet/storage/sessions:/var/www/html/app/storage/sessions',
      '/opt/intranet/storage/uploads:/var/www/html/app/storage/uploads'
    ],
    require => File['/opt/intranet/storage'],
  }

}
