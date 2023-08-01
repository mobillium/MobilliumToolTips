Pod::Spec.new do |s|
    s.name             = 'MobilliumToolTips'
    s.version          = '1.0.2'
    s.summary          = 'Simplify the user journey with customizable step-by-step guides'
    
    s.description      = <<-DESC
    You can display brief informational notes to users in the targeted areas on the desired page. Additionally, you have the ability to show or hide the buttons in the lower section.
    DESC
    
    s.homepage         = 'https://github.com/mobillium/MobilliumToolTips'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'serkan' => 'srkanerkan@gmail.com' }
    s.source           = { :git => 'https://github.com/mobillium/MobilliumToolTips.git', :tag => s.version.to_s }
    s.social_media_url = 'https://twitter.com/serkandSYM'
    s.ios.deployment_target = '13.0'
    s.swift_version = "5.0"
        
    s.source_files = [
    'MobilliumToolTips/Classes/**/*',
    'Resources/Fonts/**/*',
    'Resources/Colors/**/*',
    'Resources/Assets/**/*'
    ]
    s.resources = [
    'MobilliumToolTips/Assets/*.xcassets',
    'Resources/Fonts/*.otf'
    ]
    s.frameworks = [
    'Foundation',
    'UIKit'
    ]
    s.dependency 'MobilliumBuilders', '~> 1.5'
    s.dependency 'TinyConstraints', '~> 4.0'
end
