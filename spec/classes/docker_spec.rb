require 'spec_helper'
require 'hiera'

describe 'vision_intranet::docker' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts.merge(
          intranet_tag: 'foobar'
        )
      end
      # Default check to see if manifest compiles
      context 'compile' do
        it { is_expected.to compile.with_all_deps }
      end
      context 'contains' do
        it { is_expected.to contain_docker__image('intranet').with_image_tag('foobar') }
      end
    end
  end
end
