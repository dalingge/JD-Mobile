

------

## 编译环境
Xcode 6＋

## 运行项目
1. 安装CocoaPods (关于CocoaPods的安装和使用，可参考[这个教程](http://code4app.com/article/cocoapods-install-usage))
2. 在终端下打开项目所在的目录，执行```pod install``` (若是首次使用CocoaPods，需先执行```pod setup```)
3. ```pod install```命令执行成功后，通过新生成的xcworkspace文件打开工程运行项目

Application：这个group中放的是AppDelegate和一些系统常量及系统配置文件；

Base：一些基本父类，包括父ViewController和一些公用顶层自定义父类，其他模块的类一般都继承自这里的一些类；

Controller：系统控制层，放置ViewController，均继承于Group Base中的BaseViewController或BaseTableViewController；

View：系统中视图层，由于我比较喜欢通过代码实现界面，所以这里放的都是继承于UIView的视图，我将视图从ViewController中分离出来全部放在这里，这样能保持ViewController的精简；

Model：系统中的实体，通过类来描述系统中的一些角色和业务，同时包含对应这些角色和业务的处理逻辑；

Handler：系统业务逻辑层，负责处理系统复杂业务逻辑，上层调用者是ViewController；

Storage：简单数据存储，主要是一些键值对存储及系统外部文件的存取，包括对NSUserDefault和plist存取的封装；

Network：网络处理层(RTHttpClient)，封装了基于AFNetworking的网络处理层，通过block实现处理结果的回调，上层调用者是Handler层；

Database：数据层，封装基于FMDB的sqlite数据库存取和管理(RTDatabaseHelper)，对外提供基于Model层对象的调用接口，封装对数据的存储过程。

Utils：系统工具类(AppUtils)，主要放置一些系统常用工具类；

Categories：类别，对现有系统类和自定义类的扩展；

Resource：资源库，包括图片，plist文件等；



## 项目用到的开源类库、组件
1. AFNetworking                         网络请求
2. Masonry                              轻量级的布局框架
3. FMDB                                 轻量级的数据库
4. KINWebBrowser                        Web 浏览器模块
5. MBProgressHUD                        显示提示或加载进度
6. SDWebImage                           加载网络图片和缓存图片
7. SSKeychain                           账号密码的存取
8. TTTAttributedLabel                   支持富文本显示的label



