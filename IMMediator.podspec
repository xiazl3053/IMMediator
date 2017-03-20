#
#  Be sure to run `pod spec lint IMMediator.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "IMMediator"
  s.version      = "0.9"
  s.summary      = "新版本测试"

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description  = <<-DESC
    组件化基类
    可以通过调用ViewControllerWithJson:传入json，方式获取vc
    json格式:{@"target":@"MouduleA",@"action":@"MouduleA_Method",@"data":@{}}
    也可以通过categories的方式,调用-(id)performTarget:(NSString *)targetName 
                                           action:(NSString *)actionName 
                                           params:(NSDictionary *)params 
                                shouldCacheTarget:(BOOL)shouldCacheTarget,
    其中的targetName,组合成Moudule中的Targets类,actionName为Targets类的方法
    Target类名可以直接使用Json传输，或者通过增加前缀生成固定的方式:比如json中传入   action:Demo,类则是  TargetDemo
    Target类中实现具体的actionName的方法,相关的vc文件导入由Target类管理
    json中传输的对象，不仅仅只限于字符串，亦可是其他的对象,block,UIImage,Model,Cell...
                   DESC

  s.homepage     = "https://github.com/xiazl3053/IMMediator"
  s.license      = "MIT (example)"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author    = "xiazl3053"
  s.platform     = :ios
  s.source       = { :git => "https://github.com/xiazl3053/IMMediator.git", :tag => "#{s.version}" }
  s.source_files  = "Pods/Classes/**/*.{h,m}"
  s.public_header_files = "Pods/Classes/Mediator/*.h"
  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"
  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
