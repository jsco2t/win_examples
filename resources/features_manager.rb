#
# Cookbook Name:: win_examples
# Resource:: features_manager
#
# Copyright (C) 2016 Jason Scott
#
# License: MIT
#
require 'csv'
resource_name :features_manager

actions :install, :remove, :nothing
default_action :nothing

property :features, kind_of: Array, default: nil
property :install_dependencies, [TrueClass, FalseClass], default: false

action :nothing do
  Chef::Log.info("features_manager: skipping any work due to action: nothing")
  new_resource.updated_by_last_action(false)
end

action :remove do
  Chef::Log.info("features_manager: not supported")
  new_resource.updated_by_last_action(false)
end

action :install do
  Chef::Recipe.send(:include, Chef::Mixin::PowershellOut)

  #Chef::Log.info "features_manager input: #{features}"
  #Chef::Log.info("features_manager features: #{ps_result}")
  status = ruby_block 'Getting current feature status' do
    block do
      script = "Get-WindowsOptionalFeature -online | select FeatureName, State | ConvertTo-Csv -NoTypeInformation"
      ps_result = (powershell_out(script)).stdout.chop
      #Chef::Log.info("features_manager input: #{features}")
      #Chef::Log.info("features_manager features: #{ps_result}")
      #puts "this sucks: #{ps_result}"
      #Mixlib::Log.info('foobar')
      puts "hi: "
      puts "hi: "
      puts "hi: "
      puts "hi: "
      puts "hi: "
      puts "#{ps_result.class}"
      puts "hi again"
      foo = ps_result.split("\r\n")
      bar = ps_result.gsub! "\r\n", "\n"
      #puts "#{bar}"
      #puts "#{foo[0]}"
      CSV.parse(bar, headers:true) do |item|
        puts item
      end
    end
    action :run
  end

  new_resource.updated_by_last_action(status.updated_by_last_action?)
end
