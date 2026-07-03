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
