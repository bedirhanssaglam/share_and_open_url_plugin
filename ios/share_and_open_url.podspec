#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint share_and_open_url.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'share_and_open_url'
  s.version          = '0.0.1'
  s.summary          = 'A Flutter plugin for sharing text and opening URLs.'
  s.description      = <<-DESC
A Flutter plugin for sharing text and opening URLs.
                       DESC
  s.homepage         = 'https://github.com/bedirhanssaglam/share_and_open_url_plugin'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Bedirhan Saglam' => 'bedirhansaglam270@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
