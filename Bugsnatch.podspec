#
# Be sure to run `pod lib lint Bugsnatch.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'Bugsnatch'
    s.version          = '1.0.0'
    s.summary          = 'Bug reporting tool.'

    s.description      = <<-DESC
    Bugsnatch is a lightweight bug reporting iOS library written in Swift. It creates a bug report template by collecting application and device information. It can be triggered via a shake gesture or by taking a screenshot.
    It supports reporting bugs via an email or via the Productive tool.
    DESC

    s.homepage         = 'https://github.com/infinum/iOS-Bugsnatch'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Damjan Dabo' => 'damjan.dabo@infinum.hr' }
    s.source           = { :git => 'https://github.com/infinum/iOS-Bugsnatch.git', :tag => s.version.to_s }

    s.ios.deployment_target = '9.0'
    s.swift_version = '5.0'

    s.module_name = 'Bugsnatch'
    s.default_subspec = 'Email'

    s.subspec 'Core' do |sp|
        sp.source_files = 'Bugsnatch/Classes/Core/**/*'
        sp.frameworks = 'UIKit'
    end

    s.subspec 'Email' do |sp|
        sp.source_files = 'Bugsnatch/Classes/Email/**/*'
        sp.dependency 'Bugsnatch/Core'
    end

    s.subspec 'Productive' do |sp|
        sp.source_files = 'Bugsnatch/Classes/Productive/**/*'
        sp.dependency 'Bugsnatch/Core'
    end
end
