require 'spec_helper'

describe package('tgt') do
  it { should be_installed }
end

describe service('tgt') do
  it { should be_enabled }
  it { should be_running }
end

describe port(3260) do
  it { should be_listening }
end
describe "Checking the files if copied" do
  describe command('ls /etc/tgt/conf.d/') do
    its(:stdout){ should match 'iscsi-1.conf' }
  end

  describe command('ls /etc/tgt/conf.d/') do
    its(:stdout){ should match 'iscsi-2.conf' }
  end

  describe command('ls /etc/tgt/conf.d/') do
    its(:stdout){ should match 'iscsi-3.conf' }
  end
end
