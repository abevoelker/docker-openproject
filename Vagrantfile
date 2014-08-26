# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

ENV['VAGRANT_DEFAULT_PROVIDER'] ||= 'docker'
# Vagrant doesn't play well w/ Docker and parallel provisioning
ENV['VAGRANT_NO_PARALLEL'] ||= 'true'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "postgres" do |postgres|
    postgres.vm.provider 'docker' do |d|
      d.image  = 'paintedfox/postgresql'
      d.name   = 'openproject_postgres'
      d.env    = {
        'USER' => 'super',
        'PASS' => 'password'
      }
    end
  end

  config.vm.define "memcached" do |memcached|
    memcached.vm.provider 'docker' do |d|
      d.image  = 'tutum/memcached'
      d.name   = 'openproject_memcached'
      d.env    = {
        'MEMCACHED_PASS' => 'password'
      }
    end
  end

  config.vm.define "openproject" do |openproject|
    openproject.vm.provider 'docker' do |d|
      d.image = 'abevoelker/openproject'
      d.name  = 'openproject'
      d.cmd   = ['/var/www/openproject/docker/scripts/run_rails.sh']

      d.link('openproject_postgres:postgres')
      d.link('openproject_memcached:memcached')
    end
  end

  config.vm.define "openproject_delayed_job" do |openproject|
    openproject.vm.provider 'docker' do |d|
      d.image = 'abevoelker/openproject'
      d.name  = 'openproject_delayed_job'
      d.cmd   = ['/var/www/openproject/docker/scripts/run_background_job.sh']

      d.link('openproject_postgres:postgres')
      d.link('openproject_memcached:memcached')
    end
  end
end
