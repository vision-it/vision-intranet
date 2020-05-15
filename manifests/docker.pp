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
  Array[String] $environment        = $vision_intranet::environment,
  String $traefik_rule              = $vision_intranet::traefik_rule,
  String $intranet_digest           = $vision_intranet::intranet_tag,

) {

  ::docker::image { 'intranet':
    ensure       => present,
    image        => 'registry.gitlab.cc-asp.fraunhofer.de:4567/vision-it/application/intranet',
    image_digest => $intranet_digest,
  }

  $docker_volumes = [
    '/var/run/mysqld/mysqld.sock:/var/run/mysqld/mysqld.sock',
    '/vision/data/intranet/storage/logs:/var/www/html/storage/logs',
    '/vision/data/intranet/storage/framework:/var/www/html/storage/framework',
    '/vision/data/intranet/storage/app:/var/www/html/storage/app',
  ]

  $docker_environment = concat([
      'DB_SOCKET=/var/run/mysqld/mysqld.sock',
      "DB_DATABASE=${mysql_intranet_database}",
      "DB_USERNAME=${mysql_intranet_user}",
      "DB_PASSWORD=${mysql_intranet_password}",
  ], $environment)

  $docker_queue_environment = concat([
      'CONTAINER_ROLE=queue',
      'DB_SOCKET=/var/run/mysqld/mysqld.sock',
      "DB_DATABASE=${mysql_intranet_database}",
      "DB_USERNAME=${mysql_intranet_user}",
      "DB_PASSWORD=${mysql_intranet_password}",
  ], $environment)

  $compose = {
    'version' => '3.7',
    'services' => {
      'intranet' => {
        'image'       => "registry.gitlab.cc-asp.fraunhofer.de:4567/vision-it/application/intranet@${intranet_digest}",
        'volumes'     => $docker_volumes,
        'environment' => $docker_environment,
        'deploy' => {
          'labels' => [
            'traefik.enable=true',
            'traefik.http.services.intranet.loadbalancer.server.port=8080',
            "traefik.http.routers.intranet.rule=${traefik_rule}",
            'traefik.http.routers.intranet.entrypoints=https',
            'traefik.http.routers.intranet.tls=true',
            'traefik.http.routers.intranet.middlewares=strip-intranet@docker',
            'traefik.http.middlewares.strip-intranet.stripprefix.prefixes=/intranet',
          ],
        },
      },
      'intranet-queue' => {
        'image'       => "registry.gitlab.cc-asp.fraunhofer.de:4567/vision-it/application/intranet@${intranet_digest}",
        'volumes'     => $docker_volumes,
        'environment' => $docker_queue_environment,
      }
    }
  }
  # note: application runs on port 8080

  vision_docker::to_compose { 'intranet':
    compose => $compose,
  }

}
