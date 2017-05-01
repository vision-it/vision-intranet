require 'spec_helper_acceptance'

describe 'vision_intranet' do
  context 'with defaults' do
    it 'idempotentlies run' do
      pp = <<-EOS

        file { '/vision':
          ensure => directory,
        }

        class vision_intranet::docker () {}

        class vision_mysql::server::phpmyadmin::client(
            String $server,
            String $role,
        ) {}

        class { 'vision_intranet':

       mysql_root_password => 'foobar',
       mysql_monitoring_password => 'foobar',
       mysql_backup_password => 'foobar',

       mysql_adressen_database => 'addr',
       mysql_adressen_user => 'useradr',
       mysql_adressen_password => 'foobar',

       mysql_projekte_database => 'projekt',
       mysql_projekte_user =>  'userproj',
       mysql_projekte_password => 'foobar',

       mysql_voruntersuchungen_database => 'vor',
       mysql_voruntersuchungen_user => 'uservor',
       mysql_voruntersuchungen_password => 'foobar',

       mysql_presse_database => 'presse',
       mysql_presse_user => 'userpress',
       mysql_presse_password => 'foobar',

       mysql_intranet_database => 'intranet',
       mysql_intranet_user => 'userint',
       mysql_intranet_password => 'foobar',

       phpmyadmin_server => 'foobar.com',

        }
      EOS

      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end
  end

  context 'files provisioned' do
    describe file('/opt/intranet/storage') do
      it { is_expected.to be_directory }
    end
  end

  context 'packages installed' do
    describe package('mysql-common') do
      it { is_expected.to be_installed }
    end
    describe package('beanstalkd') do
      it { is_expected.to be_installed }
    end
  end

  context 'sql users' do
    describe command('mysql -e "select user,host from mysql.user"') do
      its(:exit_status) { is_expected.to eq 0 }
      its(:stdout) { is_expected.to match 'useradr' }
    end
  end
end
