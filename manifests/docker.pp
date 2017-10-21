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

  String $mysql_adressen_database = $vision_intranet::mysql_adressen_database,
  String $mysql_adressen_user     = $vision_intranet::mysql_adressen_user,
  String $mysql_adressen_password = $vision_intranet::mysql_adressen_password,

  String $mysql_projekte_database = $vision_intranet::mysql_projekte_database,
  String $mysql_projekte_user     = $vision_intranet::mysql_projekte_user,
  String $mysql_projekte_password = $vision_intranet::mysql_projekte_password,

  String $mysql_voruntersuchungen_database = $vision_intranet::mysql_voruntersuchungen_database,
  String $mysql_voruntersuchungen_user     = $vision_intranet::mysql_voruntersuchungen_user,
  String $mysql_voruntersuchungen_password = $vision_intranet::mysql_voruntersuchungen_password,

  String $mysql_presse_database = $vision_intranet::mysql_presse_database,
  String $mysql_presse_user     = $vision_intranet::mysql_presse_user,
  String $mysql_presse_password = $vision_intranet::mysql_presse_password,

) {

  contain ::vision_docker

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
      "DB_ADRESSEN_HOST=${::fqdn}",
      "DB_ADRESSEN_DATABASE=${mysql_adressen_database}",
      "DB_ADRESSEN_USERNAME=${mysql_adressen_user}",
      "DB_ADRESSEN_PASSWORD=${mysql_adressen_password}",
      "DB_PROJEKTE_HOST=${::fqdn}",
      "DB_PROJEKTE_DATABASE=${mysql_projekte_database}",
      "DB_PROJEKTE_USERNAME=${mysql_projekte_user}",
      "DB_PROJEKTE_PASSWORD=${mysql_projekte_password}",
      "DB_VORUNTERSUCHUNGEN_HOST=${::fqdn}",
      "DB_VORUNTERSUCHUNGEN_DATABASE=${mysql_voruntersuchungen_database}",
      "DB_VORUNTERSUCHUNGEN_USERNAME=${mysql_voruntersuchungen_user}",
      "DB_VORUNTERSUCHUNGEN_PASSWORD=${mysql_voruntersuchungen_password}",
      "DB_PRESSE_HOST=${::fqdn}",
      "DB_PRESSE_DATABASE=${mysql_presse_database}",
      "DB_PRESSE_USERNAME=${mysql_presse_user}",
      "DB_PRESSE_PASSWORD=${mysql_presse_password}",
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
