# spec/Dockerfile_spec.rb

require_relative "spec_helper"

describe "Dockerfile" do
  before(:all) do
    load_docker_image()
    set :os, family: :redhat
  end

  describe "Dockerfile#running" do
    it "runs the right version of RHEL" do
      expect(os_version).to include("Red Hat")
      expect(os_version).to include("release 8")
    end
    it "runs as service user" do
      package_name = ENV['PACKAGE_NAME']
      expect(sys_user).to eql(package_name)
    end
  end

  it "installs tomcat version" do
    expect(tomcat_version).to include(ENV['PACKAGE_VERSION'])
  end

  describe user('tomcat') do
    it { should exist }
    it { should have_uid 1000 }
    it { should belong_to_group "tomcat" }
    it { should have_login_shell '/bin/bash' }
  end

  describe group('tomcat') do
    it {should exist}
    it { should have_gid 1000}
  end

  describe file('/usr/local/tomcat') do
    it { should exist }
    it { should be_directory }
    it { should be_owned_by 'tomcat' }
    it { should be_mode 755 }
  end

  describe file('/usr/local/tomcat/bin') do
    it { should exist }
    it { should be_directory }
    it { should be_owned_by 'tomcat' }
    it { should be_mode 750 }
  end

  describe file('/usr/local/tomcat/conf') do
    it { should exist }
    it { should be_directory }
    it { should be_owned_by 'tomcat' }
    it { should be_mode 750 }
  end

  describe file('/usr/local/tomcat/webapps') do
    it { should exist }
    it { should be_directory }
    it { should be_owned_by 'tomcat' }
    it { should be_mode 750 }
  end
end
