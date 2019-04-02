require 'spec_helper'
require 'hiera'

describe 'vision_intranet' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts.merge(
          root_home: '/root',
          applicationtier: 'production'
        )
      end

      let(:pre_condition) { 'include vision_docker' }

      context 'compile' do
        it { is_expected.to compile.with_all_deps }
      end
    end
  end
end
