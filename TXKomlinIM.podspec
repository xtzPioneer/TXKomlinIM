#
# Be sure to run `pod lib lint TXKomlinIM.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  # 组件名称
  s.name             = 'TXKomlinIM'
  # 组件版本
  s.version          = '0.1.0'
  # 组件概要说明
  s.summary          = '基于XMPP开发的即时通讯功能.'
  # 组件详细说明
  s.description      = <<-DESC
  杭州空灵智能科技有限公司基于XMPP开发的即时通讯功能
                       DESC
  # 首页地址
  s.homepage         = 'https://github.com/xtzPioneer/TXKomlinIM'
  # 截图
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  # 许可
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  # 作者
  s.author           = { 'zhangxiong' => 'xtz_pioneer@163.com' }
  # 资源所在地
  s.source           = { :git => 'https://github.com/xtzPioneer/TXKomlinIM.git', :tag => s.version.to_s }
  # 社交URL
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  # 支持的版本
  s.ios.deployment_target = '8.0'
  # 是否支持ARC
  s.requires_arc = true
  # 资源文件
  s.source_files = 'TXKomlinIM/Classes/**/*.{h,m}'
  # 依赖
  s.dependency 'XMPPFramework'
  # 公开的头文件
  s.prefix_header_contents = '#import "TXKomlinIM.h"'
  # 依赖的系统framework库
  s.frameworks = 'Foundation','UIKit','XMPPFramework'
  # 支持的Swift版本
  #s.swift_version = '4.0'
  # 环境配置
  s.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2 $(PODS_ROOT)/XMPPFramework/module', 'ENABLE_BITCODE' => 'NO'}
end
