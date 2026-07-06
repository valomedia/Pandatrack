#
# Podfile
# Chronos
#
# Created by Jean-Pierre Höhmann on 2026-07-03.
#
#

platform :ios, '16.2'

project 'Chronos.xcodeproj'
use_frameworks!

target 'Chronos (iOS)' do
  pod 'ObservedOptionalObject', :podspec => 'Podspecs/ObservedOptionalObject.podspec'
  pod 'OrderedCollections', '~> 1.0'
  pod 'SwiftGen', '~> 6.6'

  target 'ChronosTests' do
    inherit! :search_paths
  end

  target 'ChronosUITests' do
    inherit! :search_paths
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '16.2'
    end
  end
end
