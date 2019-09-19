require 'spec_helper_acceptance'

describe 'vision_intranet' do
  context 'with defaults' do
    it 'idempotentlies run' do
      pp = <<-FILE

        file { ['/vision', '/vision/data/', '/vision/data/swarm']:
          ensure => directory,
        }
        group { 'docker':
          ensure => present,
        }

        # Just so that Puppet won't throw an error
       if($facts[os][distro][codename] != 'jessie') {
        file {['/etc/init.d/intranet_tag']:
          ensure  => present,
          mode    => '0777',
          content => 'case "$1" in *) exit 0 ;; esac'
        }}

        # mock classes
        class vision_intranet::database () {}
        class vision_mysql::mariadb () {}
        class vision_gluster::node () {}

        class vision_shipit::user () {}
        define vision_shipit::inotify (
         String $group,
        ) {}

        class { 'vision_intranet': }
      FILE

      apply_manifest(pp, catch_failures: true)
      # apply_manifest(pp, catch_failures: true)
    end
  end

  context 'files provisioned' do
    describe file('/vision/data/intranet/storage') do
      it { is_expected.to be_directory }
      it { is_expected.to be_owned_by 'www-data' }
    end

    describe file('/usr/local/sbin/sync-intranet.sh') do
      it { is_expected.to be_file }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_mode 750 }
      its(:content) { is_expected.to match 'intranet' }
      its(:content) { is_expected.to match 'rsync' }
    end

    describe file('/vision/data/swarm/intranet.yaml') do
      it { is_expected.to be_file }
      it { is_expected.to contain 'managed by Puppet' }
      it { is_expected.to contain 'image: registry.gitlab.cc-asp.fraunhofer.de:4567/vision-it/application/intranet:latest' }
      it { is_expected.to contain '/vision/data/intranet/storage/app:/var/www/html/storage/app' }
      it { is_expected.to contain 'intranet' }
      it { is_expected.to contain 'intranet-queue' }
      it { is_expected.to contain 'DB_SOCKET=/var/run/mysqld/mysqld.sock' }
      it { is_expected.to contain 'DB_DATABASE=intranet' }
      it { is_expected.to contain 'DB_USERNAME=userint' }
      it { is_expected.to contain 'DB_PASSWORD=foobar' }
      it { is_expected.to contain 'FOO=BAR' }
      it { is_expected.to contain 'traefik.frontend.rule=Host:example.com;PathPrefixStrip:/intranet' }
    end
  end
end
