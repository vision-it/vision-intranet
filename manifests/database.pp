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

  String $mysql_backup_password     = $vision_intranet::mysql_backup_password,
  String $mysql_intranet_database   = $vision_intranet::mysql_intranet_database,
  String $mysql_intranet_password   = $vision_intranet::mysql_intranet_password,
  String $mysql_intranet_user       = $vision_intranet::mysql_intranet_user,
  String $mysql_monitoring_password = $vision_intranet::mysql_monitoring_password,
  String $mysql_root_password       = $vision_intranet::mysql_root_password,
  String $phpmyadmin_server         = $vision_intranet::phpmyadmin_server,

) {

  class { '::vision_mysql::server':
    root_password => $mysql_root_password,
    monitoring    => {
      password => $mysql_monitoring_password,
    },
    backup        => {
      databases => ['intranet', 'adressen'],
      password  => $mysql_backup_password,
    },
    phpmyadmin    => {
      server => $phpmyadmin_server,
      role   => 'intranet',
    }
  }

  ::mysql::db { $mysql_intranet_database:
    user     => $mysql_intranet_user,
    password => $mysql_intranet_password,
    host     => '%',
    grant    => ['ALL'],
  }

}
