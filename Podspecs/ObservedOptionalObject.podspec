#
# ObservedOptionalObject.podspec
# Chronos
#
# Local CocoaPods spec for a SwiftPM-only dependency.
#

Pod::Spec.new do |s|
  s.name = 'ObservedOptionalObject'
  s.version = '0.1.1'
  s.summary = 'Observe SwiftUI objects that may be nil.'
  s.homepage = 'https://github.com/fourplusone/observed-optional-object'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.author = 'fourplusone'
  s.source = {
    :git => 'https://github.com/fourplusone/observed-optional-object.git',
    :tag => "v#{s.version}"
  }
  s.ios.deployment_target = '13.0'
  s.swift_version = '5.3'
  s.source_files = 'Sources/ObservedOptionalObject/**/*.swift'
end
