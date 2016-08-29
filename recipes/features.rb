#
# Cookbook Name:: win_examples
# Recipe:: features
#
# Copyright (C) 2016 Jason Scott
#
# License: MIT
#
=begin
%w{
  IIS-WebServerRole
  IIS-WebServer
  IIS-WebServerManagementTools
  IIS-ManagementConsole
  IIS-CommonHttpFeatures
  IIS-StaticContent
  IIS-DefaultDocument
  IIS-DirectoryBrowsing
  IIS-HttpErrors
  IIS-HttpRedirect
  IIS-ApplicationDevelopment
  IIS-ISAPIExtensions
  IIS-Security
  IIS-RequestFiltering
  IIS-NetFxExtensibility
  IIS-BasicAuthentication
  IIS-Performance
  IIS-HttpCompressionDynamic
  IIS-HttpCompressionStatic
  IIS-ISAPIFilter
  NetFx3ServerFeatures
  NetFx3
  NetFx4Extended-ASPNET45
  IIS-NetFxExtensibility45
  IIS-ASPNET45
}.each do |feature|
  windows_feature feature do
    action :install
    all true
  end
end
=end

=begin #small test set
features_toinstall = [
  'IIS-WebServerRole',
  'IIS-WebServer',
  'IIS-WebServerManagementTools',
  'IIS-ManagementConsole',
  'IIS-CommonHttpFeatures'
]
=end

# large test set:
features_toinstall = [
  'IIS-WebServerRole',
  'IIS-WebServer',
  'IIS-WebServerManagementTools',
  'IIS-ManagementConsole',
  'IIS-CommonHttpFeatures',
  'IIS-StaticContent',
  'IIS-DefaultDocument',
  'IIS-DirectoryBrowsing',
  'IIS-HttpErrors',
  'IIS-HttpRedirect',
  'IIS-ApplicationDevelopment',
  'IIS-ISAPIExtensions',
  'IIS-Security',
  'IIS-RequestFiltering',
  'IIS-NetFxExtensibility',
  'IIS-BasicAuthentication',
  'IIS-Performance',
  'IIS-HttpCompressionDynamic',
  'IIS-HttpCompressionStatic',
  'IIS-ISAPIFilter',
  'NetFx3ServerFeatures',
  'NetFx3',
  'NetFx4Extended-ASPNET45',
  'IIS-NetFxExtensibility45',
  'IIS-ASPNET45'
]

=begin
features_toinstall.each do |feature|
  windows_feature feature do
    action :install
    all true
  end
end
=end

features_manager 'Installing features' do
  action :install
  features features_toinstall
  install_dependencies true
end
