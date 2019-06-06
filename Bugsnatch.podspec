#
# Be sure to run `pod lib lint Bugsnatch.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Bugsnatch'
  s.version          = '0.1.0'
  s.summary          = 'A short description of Bugsnatch.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/infinum/iOS-Bugsnatch'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Damjan Dabo' => 'damjan.dabo@infinum.hr' }
  s.source           = { :git => 'https://github.com/infinum/iOS-Bugsnatch.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.swift_version = '5.0'

  s.module_name = 'Bugsnatch'
  s.default_subspec = 'Email'

  s.subspec 'Core' do |sp|
      sp.source_files = 'iOS-Bugsnatch/Classes/Core/**/*'
      sp.frameworks = 'Foundation'
  end

  s.subspec 'Email' do |sp|
      sp.source_files = 'iOS-Bugsnatch/Classes/Email/**/*'
      sp.dependency 'iOS-Bugsnatch/Core'
  end

  s.subspec 'Productive' do |sp|
      sp.source_files = 'iOS-Bugsnatch/Classes/Productive/**/*'
      sp.dependency 'iOS-Bugsnatch/Core'
  end
end
