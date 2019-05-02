# Class: vision_intranet::database
# ===========================
#
# Parameters
# ----------
#
# Examples
# --------
#
# @example
# contain ::vision_intranet::database
#

class vision_intranet::database_beta (

  String $mysql_intranet_database = $vision_intranet::beta::mysql_intranet_database,
  String $mysql_intranet_password = $vision_intranet::beta::mysql_intranet_password,
  String $mysql_intranet_user = $vision_intranet::beta::mysql_intranet_user,
  String $mysql_root_password = $vision_intranet::beta::mysql_root_password,
  Optional[String] $mysql_backup_password = $vision_intranet::beta::mysql_backup_password,

) {

  if !defined(Class['::vision_mysql::server']) {
    # no backups in staging environment
    if $::applicationtier == 'staging' {
      class { '::vision_mysql::server':
        root_password => $mysql_root_password,
      }
    } else {
      class { '::vision_mysql::server':
        root_password => $mysql_root_password,
        backup        => {
          databases => [$mysql_intranet_database],
          password  => $mysql_backup_password,
        }
      }
    }
  }

  ::mysql::db { $mysql_intranet_database:
    user     => $mysql_intranet_user,
    password => $mysql_intranet_password,
    host     => '%',
    grant    => ['ALL'],
    require  => Class['::vision_mysql::server'],
  }

}
