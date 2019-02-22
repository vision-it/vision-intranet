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

        # Just so that Puppet won't throw an error
       if($facts[os][distro][codename] != 'jessie') {
        file {['/etc/init.d/intranet_tag']:
          ensure  => present,
          mode    => '0777',
          content => 'case "$1" in *) exit 0 ;; esac'
        }}

        # Mocking
        class vision_intranet::docker () {}
        class vision_intranet::database () {}
        class vision_docker () {}

        class { 'vision_intranet': }
      FILE

      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_failures: true)
    end
  end

  context 'files provisioned' do
    describe file('/opt/intranet/storage') do
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
  end

  context 'Jenkins user and service' do
    describe user('jenkins') do
      it { is_expected.to exist }
      it { is_expected.to have_uid 50_000 }
    end

    describe file('/etc/systemd/system/intranet_tag.service') do
      it { is_expected.to be_file }
    end
  end
end
