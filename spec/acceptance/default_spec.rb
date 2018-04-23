require 'spec_helper_acceptance'

describe 'vision_intranet' do
  context 'with defaults' do
    it 'idempotentlies run' do
      pp = <<-FILE

        file { '/vision':
          ensure => directory,
        }
        group { 'docker':
          ensure => present,
        }

        # Mocking
        class vision_intranet::docker () {}
        class vision_docker () {}
        class vision_mysql::server::phpmyadmin::client(
            String $server,
            String $role,
        ) {}

        class { 'vision_intranet':
            mysql_root_password => 'foobar',
            mysql_monitoring_password => 'foobar',
            mysql_backup_password => 'foobar',
            mysql_intranet_database => 'intranet',
            mysql_intranet_user => 'userint',
            mysql_intranet_password => 'foobar',
            phpmyadmin_server => 'foobar.com',
        }
      FILE

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
  end
end
