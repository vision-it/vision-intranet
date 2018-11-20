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

class vision_intranet::database (


  String $mysql_intranet_database = $vision_intranet::mysql_intranet_database,
  String $mysql_intranet_password = $vision_intranet::mysql_intranet_password,
  String $mysql_intranet_user = $vision_intranet::mysql_intranet_user,
  Optional[String] $mysql_monitoring_password = $vision_intranet::mysql_monitoring_password,
  Optional[String] $mysql_root_password = $vision_intranet::mysql_root_password,
  Optional[String] $mysql_backup_password = $vision_intranet::mysql_backup_password,

) {

  if !defined(Class['::vision_mysql::server']) {
    class { '::vision_mysql::server':
      root_password => $mysql_root_password,
      monitoring    => {
        password => $mysql_monitoring_password,
      },
      backup        => {
        databases => [$mysql_intranet_database],
        password  => $mysql_backup_password,
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
