require 'spec_helper'

describe package('tgt') do
  it { should be_installed }
end

describe service('tgt') do
  it { should be_enabled }
  it { should be_running }
end

describe "Checking the pools" do
  describe command('sudo ceph osd lspools') do
    its(:stdout) {should match 'iscsi.1' }
  end
  describe command('sudo ceph osd lspools') do
    its(:stdout) {should match 'iscsi.2' }
  end
  describe command('sudo ceph osd lspools') do
    its(:stdout) {should match 'iscsi.2' }
  end
end

describe "Checking the rbd images" do
  describe command('sudo rbd ls iscsi.1') do
    its(:stdout) {should match 'iscsi-rbd.1' }
  end
  describe command('sudo rbd ls iscsi.2') do
    its(:stdout) {should match 'iscsi-rbd.2' }
  end
  describe command('sudo rbd ls iscsi.3') do
    its(:stdout) {should match 'iscsi-rbd.3' }
  end
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
