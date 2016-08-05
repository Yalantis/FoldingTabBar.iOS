Pod::Spec.new do |spec|
  spec.name = "FoldingTabBar"
  spec.version = "1.0.7"

  spec.homepage = "https://github.com/Yalantis/FoldingTabBar.iOS"
  spec.summary = "Folding Tab Bar and Tab Bar Controller"

  spec.author = "Yalantis"
  spec.license = { :type => "MIT", :file => "LICENSE" }
  spec.social_media_url = "https://twitter.com/yalantis"

  spec.platform = :ios, '7.0'
  spec.ios.deployment_target = '7.0'

  spec.source = { :git => "https://github.com/Yalantis/FoldingTabBar.iOS.git", :tag => spec.version }

  spec.requires_arc = true

  spec.source_files = 'FoldingTabBar/**/*'
  spec.public_header_files = 'FoldingTabBar/**/*.h'
  spec.frameworks = 'UIKit', 'QuartzCore'
  spec.requires_arc = true
end