# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'etc'

Vagrant.configure("2") do |config|
  config.vm.box = "base"

  if Vagrant.has_plugin?('vagrant-env')
    config.env.enable
  end

  machine_name = ENV['MACHINE_NAME'] || ("vmck-vagrant-" + `hostname`.strip)
  custom_sh = ENV['PROVISION_SH']

  config.vm.define machine_name
  config.nfs.functional = false

  config.vm.synced_folder "..", "/opt/vmck", type: "rsync",
      rsync__exclude: [".git/"]

  config.vm.provision(
      'provider',
      preserve_order: true,
      type: 'shell',
      path: "provision.sh",
      inline: nil,
      privileged: false,
    )

  config.vm.provider :vmck do |vmck|
    vmck.vmck_url = ENV['VMCK_URL']
    vmck.image_path = 'imgbuild-acs-pc.qcow2.tar.gz'
    vmck.memory = 1024 * 2
    vmck.cpus = 1
  end
end
