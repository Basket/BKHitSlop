Pod::Spec.new do |s|
  s.name             = "BKHitSlop"
  s.version          = "0.0.1"
  s.summary          = "A simple swizzle to allow UIViews to respond to touches outside their visible bounds."
  s.description      = <<-DESC
                       This is mostly useful for UIButtons for which a specific size/positioning is desired, but which should also be responsive to touches outside of its drawn area.
                       DESC
  s.homepage         = "https://github.com/Basket/BKHitSlop"
  s.license          = 'MIT'
  s.author           = { "Andrew Toulouse" => "andrew@atoulou.se" }
  s.source           = { :git => "https://github.com/Basket/BKHitSlop.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'BKHitSlop/*.{h,m}'
  s.frameworks = 'UIKit'
end
