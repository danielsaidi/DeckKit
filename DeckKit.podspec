# Run `pod lib lint DeckKit.podspec' to ensure this is a valid spec.

Pod::Spec.new do |s|
  s.name             = 'DeckKit'
  s.version          = '0.1.2'
  s.swift_versions   = ['5.3']
  s.summary          = 'DeckKit contains tools for building deck-based apps.'

  s.description      = <<-DESC
  DeckKit is a SwiftUI library with tools for building deck-based apps, like Tinder-styled apps? :)
                       DESC

  s.homepage         = 'https://github.com/danielsaidi/DeckKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Daniel Saidi' => 'daniel.saidi@gmail.com' }
  s.source           = { :git => 'https://github.com/danielsaidi/DeckKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/danielsaidi'

  s.swift_version = '5.3'
  s.ios.deployment_target = '13.0'
  s.tvos.deployment_target = '13.0'
  # s.macos.deployment_target = '11.0'  Re-add after upgrading to Big Sur.
  s.watchos.deployment_target = '6.0'
  
  s.source_files = 'Sources/**/*.swift'
end
