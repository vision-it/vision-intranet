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

) {

  ::mysql::db { $mysql_intranet_database:
    user     => $mysql_intranet_user,
    password => $mysql_intranet_password,
    host     => 'localhost',
    grant    => ['ALL'],
  }

}
