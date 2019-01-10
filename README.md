# XQComponentTmp
自定义私有库目录的模版项目，用于公共、业务组件的构造。

# 需求原因
## 1、项目业务增多
主项目随着业务的增多，体积和代码量越来越大，代码耦合性高，也不利于bug的定位，新同事也需要花很长时间消化。故将项目组件化提上日程——主项目由主项目代码+公共组件库+业务需求组件等构成，目录如下：
```
//主项目
—— XQMainProject  
/*主项目无法组件化的代码*/
└── XQMainProjectCode 

/*公共组件*/
//通用的UI控件库
└── XQ_UIKit
//公共的Category，工具类，宏定义等
└── XQ_UIFoundation
...

/*业务组件*/
//新闻模块
└── XQ_News
//商城模块
└── XQ_Store
//视频模块
└── XQ_Video
...
```

---
## 2、分析 pod lib create 创建的私有库

在终端中执行：
```  
pod lib create  <LibName>
```
如
```
pod lib create XQComponentTmp
```
然后按提示进行配置，最后会生成如下图所示的目录结构：

![传统方式创建的XQComponentTmp项目目录](https://upload-images.jianshu.io/upload_images/223149-7cd2fb47fff633cd.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

由上图可知，创建后的项目目录整理如下：
```
—— XQComponentTmp  
/*Pods项目的副本*/
└── _Pods.xcodeproj
/*私有库的演示demo项目*/
└── Example 
         /*demo项目代码*/
        └── XQComponentTmp
        /*demo项目*/
        └── XQComponentTmp.xcodeproj 
        /*xcworkspace，管理demo项目和Pods项目*/
        └── XQComponentTmp.xcworkspace 
        /*Podfile文件*/
        └── Podfile
        /*Pods相关的文件*/
        └── Pods
         ...
/*私有库*/
└── XQComponentTmp
         /*私有库资源文件*/
        └── Assets
         /*私有库所有代码文件*/
        └── Classes
/*私有库的podspec文件*/
└── XQComponentTmp.podspec
/*Git管理相关文件*/
└──.git
...
```
所以，这种方式创建的工程目录这么几点不太便捷：

1、git和私有库代码在一级目录，pods在二级目录，若私有库发生更改，则提交代码到远程仓库需切换到一级目录，演示demo项目更新私有库需回到二级目录。更改频繁，需频繁切换，容易造成错误。

2、观察workspace目录结构，Pods引入了私有库XQComponentTmp，且代码嵌套在三级目录，不方便查看管理。

![workspace目录结构](https://upload-images.jianshu.io/upload_images/223149-5516f32265d7c284.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

由上图也可感受到，整个项目目录并不怎么清爽，故构思自定义私有库的目录结构，使得git管理和pod管理在一个目录结构下，且整个代码架构清新。

---
# 自定义私有库的搭建目录
### 1、自定义的私有库目录结构：
```
—— XQComponentTmp  
/*私有库的podspec文件*/
└── XQComponentTmp.podspec
/*私有库项目*/
└── XQComponentTmp.xcodeproj
/*私有库的所有代码资源文件*/
└── XQComponentTmp
        /*私有库资源文件*/
        └── Assets
        /*私有库所有代码文件*/
        └── Classes
/*演示demo*/
└── XQComponentTmpDemo 
        /*demo项目*/
        └── XQComponentTmpDemo.xcodeproj
        /*demo项目的所有代码资源文件*/
        └── XQComponentTmpDemo 
/*workspace文件*/
└──XQComponentTmp.xcworkspace
/*Podfile文件*/
└── Podfile
/*Pods相关的文件*/
└── Pods
/*Git管理相关文件*/
└──.git
...
```
* 将`Pods`和`Git`放在一级目录，方便管理操作。
* 将私有库文件夹还是放在一级目录，其代码和资源通过项目来管理，初步构思是利用静态库。`workspace`同时管理`XQComponentTmpDemo.xcodeproj`、`Pods.xcodeproj`、`XQComponentTmp.xcodeproj`。如此就不用在`workspace`中的`Pods`下去编辑私有库文件。

### 2、实践
##### 2.1、创建私有库
* `Xcode`中创建新的 `project`，选择 静态库模版 `Cocoa Touch Framework`，命名为XQComponentTmp。
* 然后在`XQComponentTmp/XQComponentTmp`目录下创建两个文件夹 `Classes`、`Assets`，用于存放私有库文件和资源，引入到项目中。
* 创建podspec文件：
```
pod spec create <LibName> //此处LibName为XQComponentTmp
```
编辑配置：
```
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
    s.author           = { 'xq' => 'xxx@gmail.com' }
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
    #s.dependency 'BeeHive', '1.6.0'
    #s.dependency 'JLRoutes', '2.1'
    #s.dependency 'JSONModel', '~> 1.7.0'
    #s.dependency 'Masonry', '~> 1.1.0'
end

```
那么此时私有库项目就初步创建完成，可以在Classes目录下简单创建私有库文件：

![私有库项目目录](https://upload-images.jianshu.io/upload_images/223149-4f63c3a640926df4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

##### 2.2、创建Demo演示项目
demo项目用于演示如何使用私有库，方便主项目快速集成使用。
* 在`XQComponentTmp/`目录下创建一个新的项目应用`XQComponentTmpDemo`，模版可直接选择`Single View App`。
* 然后在同一目录创建和编辑Podfile
```
/*创建*/
touch Podfile
/*编辑*/
vim Podfile
```
编辑后如下：
```
#use_frameworks!

platform :ios, '8.0'
#指定源
source 'https://github.com/CocoaPods/Specs.git'

# 辨识是哪个workspace，没有则创建名为XQComponentTmp的workspace
workspace 'XQComponentTmp'

# 辨识是哪个target
target 'XQComponentTmpDemo' do
    # 辨识是哪个项目
    project 'XQComponentTmpDemo/XQComponentTmpDemo.xcodeproj'
    # 引入私有库（同级路径）
    pod 'XQComponentTmp', :path => './'

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

```
* 然后在同一目录执行`pod`安装：
```
pod install
```
此时demo项目已经完成了私有库的引入，完整文件目录如下所示：

![项目目录](https://upload-images.jianshu.io/upload_images/223149-304d48f591337bb5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

* 打开`workspace`，此时`workspace`管理了`XQComponentTmpDemo.xcodeproj`、`Pods.xcodeproj`两个项目，直接将`XQComponentTmp.xcodeproj`拖入到`workspace`中，即可完成`workspace`管理三个项目。
![完整的项目目录](https://upload-images.jianshu.io/upload_images/223149-8f7a924b06b4a0ed.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

由此，完成了自定义私有库目录的构造。
1）编辑私有库，可直接忽略Pods部分，在`XQComponentTmp.xcodeproj`目录下进行编辑，结构更清晰。
2）若私有库中增删了文件，需要执行pod install后，demo项目引入的私有库才能生效，若仅仅是编辑了某文件，如增加了某个方法，demo项目直接生效。

##### 2.3、测试私有库
* 在私有库的Classes中创建文件：XQTestView.h/m文件
```
- (id)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}
```
* 新增了文件，故执行`pod install`，使得demo项目引入私有库最新代码，编辑demo的`ViewController.m`文件：
```
- (void)viewDidLoad {
    [super viewDidLoad];

    //test component
    XQTestView *testView = [[XQTestView alloc]init];
    testView.frame = CGRectMake(0, 0, 100, 100);
    testView.center  = self.view.center;
    [self.view addSubview:testView];
}
```
* 选择XQComponentTmpDemo工程，编译运行：

![测试结果](https://upload-images.jianshu.io/upload_images/223149-41d5d3718f8d085a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 3、补充
##### 3.1、私有库依赖其他库
1）若私有库本身有依赖其他库（第三方库、私有库等），如`xxx.podspec`文件中：
```
 #依赖的第三方库
s.dependency 'JSONModel', '~> 1.7.0'
```
2）这个私有库也需要`pod`管理依赖的第三方库，所以`podfile`中添加如下：
```
target 'XQComponentTmp' do
    # 辨识是哪个项目
    project 'XQComponentTmp.xcodeproj'
    pod 'JSONModel', '~> 1.7.0'
end
```
3）执行`pod install`，这样私有库即能成功和第三方库进行管理。

4）测试：
在XQComponentTmp/Class目录下，添加继承于`JSONModel`的子类`XQTestModel`，然后编译`XQComponentTmp`：

![](https://upload-images.jianshu.io/upload_images/223149-604de552e544d461.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

若编译成功，说明`XQTestModel.h`中成功`#import "JSONModel.h"`，即成功关联上第三方库。私有库引用第三方库成功！

##### 3.2、添加代码格式化
`clang-format` 是真正实现代码规范的执行文件（网上找的，可以配置代码规范规则，之后抽空研究下），利用`shell`脚本，在编译时，动态执行`clang-format`，来实现进行代码格式化。`shell`脚本`formatCodeStyle.sh`如下所示 :
```
#!/bin/sh
clang_format=$SRCROOT/bin/clang-format
run_clangformat() {
    local filename="${1}"
    cd $SRCROOT
    if [ ! -f "$filename" ]; then
    return
    fi
    FILE_ALIAS='file'

    if [[ "${filename##*.}" == "m" || "${filename##*.}" == "h" || "${filename##*.}" == "mm" || "${filename##*.}" == "hpp" || "${filename##*.}" == "cpp" || "${filename##*.}" == "cc" ]]; then
    echo "$SRCROOT/$filename"
    echo "存在"
    $clang_format -i -style=$FILE_ALIAS "$SRCROOT/$filename"
    fi
}

git diff --name-only | grep "XQComponentTmp/" | while read filename; do run_clangformat "${filename}"; done

```

`shell`脚本配置：选中需要添加代码规范的文件所属的`Target`，`Build Phases` 下 `New Run Script Phase`：

![](https://upload-images.jianshu.io/upload_images/223149-271bf7de79f26871.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```
echo "开始格式化"
"${SRCROOT}/scripts/formatCodeStyle.sh"
```
这样，每次编译，该工程的所有文件代码，就自动进行了格式化。（可以用if-else进行测试）

---

# 其他

# Author
laixuefei0216@gmail.com


# License

XQComponentTmp is available under the MIT license. See the LICENSE file for more info.

