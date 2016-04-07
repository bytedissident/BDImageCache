Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '8.0'
s.name = "BDImageCache"
s.summary = "High Performance Image caching library that integrates FLAnimatedImage for multiple GIF display"
s.requires_arc = true

# 2
s.version = "0.1.0"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "Derek Bronston" => "dbronston@me.com" }

# For example,
# s.author = { "Joshua Greene" => "jrg.developer@gmail.com" }


# 5 - Replace this URL with your own Github page's URL (from the address bar)
s.homepage = "https://github.com/bytedissident/BDImageCache"

# For example,
# s.homepage = "https://github.com/JRG-Developer/RWPickFlavor"


# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "git@github.com:bytedissident/BDImageCache.git", :tag => "#{s.version}"}

# For example,
# s.source = { :git => "https://github.com/JRG-Developer/RWPickFlavor.git", :tag => "#{s.version}"}


# 7
s.framework = "UIKit"
s.dependency 'FLAnimatedImage', '~> 1.0'


# 8
s.source_files = "BDImageCache/**/*.{swift}"

# 9
#s.resources = "BDImageCache/**/*.{png,jpeg,jpg,storyboard,xib}"
end