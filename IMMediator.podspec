Pod::Spec.new do |s|
  s.name         = "IMMediator"
  s.version      = "0.1.0"
  s.summary      = "组件pods测试"
  s.description  = <<-DESC
1.代码解耦，提高重用，降低依赖
                   DESC

  s.homepage     = "https://github.com/xiazl3053/IMMediator"
  s.license      = "MIT (example)"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "xiazl3053" => "xiazl1987@gmail.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/xiazl3053/IMMediator.git", :tag => "#{s.version}" }
  s.source_files  = "IMMediator/Classes/*.{h,m}"
  #s.exclude_files = "Classes/Exclude"
  

  s.public_header_files = "IMMediator/Classes/*.h"
  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
