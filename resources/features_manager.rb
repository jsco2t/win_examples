#
# Cookbook Name:: win_examples
# Resource:: features_manager
#
# Copyright (C) 2016 Jason Scott
#
# License: MIT
#
#require 'csv'
Chef::Recipe.send(:include, Chef::Mixin::PowershellOut)

resource_name :features_manager
actions :install, :remove, :nothing
default_action :nothing

property :features, kind_of: Array, default: []
property :install_dependencies, [TrueClass, FalseClass], default: false

#
# local vars and methods
#
features_toinstall = []

def get_features_toinstall
  if features != nil && features.length == 0
    throw "Input parameter [features] was either null or empty"
  end

  script = "Get-WindowsOptionalFeature -online | select FeatureName, State | ConvertTo-Csv -NoTypeInformation"
  ps_result = (powershell_out(script)).stdout.chop

  if ps_result.to_s == ''
    throw "PowerShell request for features failed."
  end

  raw_features = ps_result.gsub! "\r\n", ","
  raw_features = ps_result.gsub! "\"", ""
  feature_state = Hash[*raw_features.split(',')]

  enabled_features = feature_state.select { |key,value|
    ((features.include? key) == true && value.downcase == 'enabled')
  }

  enabled_feature_names = enabled_features.keys
  features_toinstall = features - enabled_feature_names
  return features_toinstall
end

#
# supported actions
#
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

  status = ruby_block 'Getting current feature status' do
    block do

      features_toinstall.each do |feature|
        windows_feature feature do
          action :install
          all true
        end
      end

    end
    action :run
    only_if do
      (
        features_toinstall = get_features_toinstall
      )
      features_toinstall.length > 0
    end
  end

  new_resource.updated_by_last_action(status.updated_by_last_action?)
end
