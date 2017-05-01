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

  String $mysql_root_password       = $vision_intranet::mysql_root_password,
  String $mysql_monitoring_password = $vision_intranet::mysql_monitoring_password,
  String $mysql_backup_password     = $vision_intranet::mysql_backup_password,

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

  String $mysql_intranet_database = $vision_intranet::mysql_intranet_database,
  String $mysql_intranet_user     = $vision_intranet::mysql_intranet_user,
  String $mysql_intranet_password = $vision_intranet::mysql_intranet_password,

  String $phpmyadmin_server = $vision_intranet::phpmyadmin_server,


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
  mysql_grant { "${mysql_presse_user}@%/adressen.*":
    ensure     => 'present',
    options    => ['GRANT'],
    privileges => ['ALL'],
    table      => 'adressen.*',
    user       => "${mysql_presse_user}@%",
  }
  mysql_grant { "${mysql_projekte_user}@%/adressen.*":
    ensure     => 'present',
    options    => ['GRANT'],
    privileges => ['ALL'],
    table      => 'adressen.*',
    user       => "${mysql_projekte_user}@%",
  }
  mysql_grant { "${mysql_voruntersuchungen_user}@%/adressen.*":
    ensure     => 'present',
    options    => ['GRANT'],
    privileges => ['ALL'],
    table      => 'adressen.*',
    user       => "${mysql_voruntersuchungen_user}@%",
  }
  mysql_grant { "${mysql_intranet_user}@%/adressen.*":
    ensure     => 'present',
    options    => ['GRANT'],
    privileges => ['ALL'],
    table      => 'adressen.*',
    user       => "${mysql_intranet_user}@%",
  }
  ::mysql::db { $mysql_adressen_database:
    user     => $mysql_adressen_user,
    password => $mysql_adressen_password,
    host     => '%',
    grant    => ['ALL'],
  }
  ::mysql::db { $mysql_projekte_database:
    user     => $mysql_projekte_user,
    password => $mysql_projekte_password,
    host     => '%',
    grant    => ['ALL'],
  }
  ::mysql::db { $mysql_presse_database:
    user     => $mysql_presse_user,
    password => $mysql_presse_password,
    host     => '%',
    grant    => ['ALL'],
  }
  ::mysql::db { $mysql_voruntersuchungen_database:
    user     => $mysql_voruntersuchungen_user,
    password => $mysql_voruntersuchungen_password,
    host     => '%',
    grant    => ['ALL'],
  }

}
