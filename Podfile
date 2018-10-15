#use_frameworks!

platform :ios, '8.0'
#指定源
source 'https://github.com/CocoaPods/Specs.git'

# 辨识是哪个workspace
workspace 'XQComponentTmp'

target 'XQComponentTmpDemo' do
    # 辨识是哪个项目
    project 'XQComponentTmpDemo/XQComponentTmpDemo.xcodeproj'
    pod 'XQComponentTmp', :path => './'

end

target 'XQComponentTmp' do
    pod 'JSONModel', '~> 1.7.0'

end

################## Pods Script ###################
#配置Pods工程预编译宏
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            if config.name.include?('Debug')
                config.build_settings['GCC_OPTIMIZATION_LEVEL'] = 0
            end
        end
    end
end
