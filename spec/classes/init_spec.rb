require 'spec_helper'
describe 'redis' do
  it { should contain_package('epel-release') }
  it { should contain_package('redis') }
end
