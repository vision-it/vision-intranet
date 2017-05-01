require 'spec_helper'
require 'hiera'

describe 'vision_intranet' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts.merge(root_home: '/root')
      end

      let :pre_condition do
        [
          'class vision_docker() {}',
          'class vision_mysql::server::phpmyadmin::client(
            String $server,
            String $role,
           ) {}'
        ]
      end

      context 'compile' do
        it { is_expected.to compile }
      end
    end
  end
end
