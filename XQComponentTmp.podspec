#
# Be sure to run `pod lib lint XQComponentTmp.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'XQComponentTmp'
    s.version          = '0.1.0'
    s.summary          = 'XQ自定义组件模版'

    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!

    s.description      = <<-DESC
    XQ自定义组件模版，用于公共、业务组件的构造。
    DESC

    s.homepage         = 'https://github.com/xq0216/XQComponentTmp'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'laixuefei' => 'laixuefei0216@gmail.com' }
    s.source           = { :git => 'git@github.com:xq0216/XQComponentTmp.git', :tag => s.version.to_s }

    s.ios.deployment_target = '8.0'

    s.source_files = 'XQComponentTmp/Classes/**/*'

    s.resource_bundle = {
        'XQComponentTmp_Bundle' => ['XQComponentTmp/Assets/*.xcassets']
    }

    s.public_header_files = 'XQComponentTmp/Classes/**/*.h'

    #依赖的系统库
    s.frameworks = 'UIKit', 'Foundation', 'CoreGraphics'

    #依赖的第三方库
    s.dependency 'JSONModel', '~> 1.7.0'
    #s.dependency 'BeeHive', '1.6.0'
    #s.dependency 'JLRoutes', '2.1'
    #s.dependency 'Masonry', '~> 1.1.0'
end
