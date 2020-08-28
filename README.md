# BXKAdvert集成指南

## Cocoapods自动集成（推荐）

Cocoapods会自动安装BXKAdvert相关依赖(AFNetworking,Masonry,SDWebImage)，如工程target名为BXKDemo，在项目根目录的Podfile添加BXKAdvert并调用`pod install`：

```objective-c
target 'BXKDemo' do
   pod 'BXKAdvertSDK'
end
```

## 手动集成

### 工程配置

1. [下载BXKAdvert](https://github.com/dataoke-ad/BXKAdvertSDK_iOS.git)，解压.zip文件得到相应源码及资源文件。

2. Xcode`File` —> `Add Files to "Your Project"`，在弹出Panel选中所下载组件包－>`Add`。（注：选中“Copy items if needed”）

   ![image-20200828105206731](/Users/wit/Library/Application Support/typora-user-images/image-20200828105206731.png)

3. 添加依赖库`SDWebImage` `Masonry` `AFNetworking`

![image-20200828113155014](/Users/wit/Library/Application Support/typora-user-images/image-20200828113155014.png)





## 初始化

 ```objective-c
/// **@param** key 你申请的key，必传
/// **@param** appKey 你申请的appKey，必传
+ (void)registerWithKey:(NSString *)key appKey:(NSString *)appKey;
 ```

示例代码

```objective-c
#import <BXKAdvertSDK/BXKAdvertSDK.h>

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [BXKAdvertSDK registerWithKey:@"你的key" appKey:@"你的appKey"];
}
```

创建广告组件步骤：

1、创建广告对象：

```objective-c
@interface ViewController ()
<BXKAdvertDelegate>

@property (nonatomic, strong) id<BXKAdvertProtocol> advert;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.advert = [BXKAdvertFactory createWithType:BXKAdvertTypeStartupScreen comId:@"1886" delegate:self];
    [self.advert startRequest];
}
```

2、设置代理回调

```objective-c
#pragma mark - BXKAdvertDelegate

// 广告加载成功后的回调，advert广告对象里的view即是你需要展示的视图
- (void)advert:(id<BXKAdvertProtocol>)advert didRequestSuccess:(NSDictionary *)response {

}

// 广告加载失败后的回调
- (void)advert:(id<BXKAdvertProtocol>)advert didRequestFailure:(NSError *)error {
    
}

// 广告点击回调
- (void)advert:(id<BXKAdvertProtocol>)advert didClickWithLandingLink:(NSString *)landingLink {
    
}
```



## 开屏组件

```objective-c
import "BXKViewController.h"
#import <BXKAdvertSDK/BXKAdvertSDK.h>
#import "BXKTestViewController.h"
#import "BXKWebViewController.h"

#define SDKKey     @"eebf41de"
#define SDKAppKey @"6a4188fa009807a30b9dc4e0df3d2a05"

@interface BXKViewController ()
<BXKAdvertDelegate>

@property (nonatomic, strong) id<BXKAdvertProtocol> advert;

@end

@implementation BXKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.advert = [BXKAdvertFactory createWithType:BXKAdvertTypeStartupScreen comId:你的组件id delegate:self];    // 初始化广告
    [self.advert startRequest];    // 开始请求
}


#pragma mark - BXKAdvertDelegate

-(void)advert:(id<BXKAdvertProtocol>)advert didRequestSuccess:(NSDictionary *)response {
    if (advert.type == BXKAdvertTypeStartupScreen) {
            // 显示广告
        BXKTestViewController *vc = [[BXKTestViewController alloc] init];
        vc.advert = advert;
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:vc animated:YES completion:nil];
    }
}

- (void)advert:(id<BXKAdvertProtocol>)advert didRequestFailure:(NSError *)error {
    
}

-(void)advert:(id<BXKAdvertProtocol>)advert didClickWithLandingLink:(NSString *)landingLink {
        // 处理跳转逻辑
    [self dismissViewControllerAnimated:YES completion:nil];
    BXKWebViewController *webVC = [[BXKWebViewController alloc] init];
    webVC.URLString = landingLink;
    [self.navigationController pushViewController:webVC animated:YES];
}

@end
```



## 信息流组件

```objective-c
import "BXKViewController.h"
#import <BXKAdvertSDK/BXKAdvertSDK.h>
#import "BXKTestViewController.h"
#import "BXKWebViewController.h"

#define SDKKey     @"eebf41de"
#define SDKAppKey @"6a4188fa009807a30b9dc4e0df3d2a05"

@interface BXKViewController ()
<BXKAdvertDelegate>

@property (nonatomic, strong) id<BXKAdvertProtocol> advert;

@end

@implementation BXKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.advert = [BXKAdvertFactory createWithType:BXKAdvertTypeInfoFlow comId:你的组件id delegate:self];    // 初始化广告
    [self.advert startRequest];    // 开始请求
}


#pragma mark - BXKAdvertDelegate

-(void)advert:(id<BXKAdvertProtocol>)advert didRequestSuccess:(NSDictionary *)response {
    if (advert.type == BXKAdvertTypeInfoFlow) {
            // 显示广告
        // 推荐高度为110
        advert.view.frame = CGRectMake(0, 100, CGRectGetWidth(self.view.bounds), 110);
        [self.view addSubview:advert];
    }
}

- (void)advert:(id<BXKAdvertProtocol>)advert didRequestFailure:(NSError *)error {
    
}

-(void)advert:(id<BXKAdvertProtocol>)advert didClickWithLandingLink:(NSString *)landingLink {
        // 处理跳转逻辑
    BXKWebViewController *webVC = [[BXKWebViewController alloc] init];
    webVC.URLString = landingLink;
    [self.navigationController pushViewController:webVC animated:YES];
}

@end
```



## 搜索组件

```objective-c
import "BXKViewController.h"
#import <BXKAdvertSDK/BXKAdvertSDK.h>
#import "BXKTestViewController.h"
#import "BXKWebViewController.h"

#define SDKKey     @"eebf41de"
#define SDKAppKey @"6a4188fa009807a30b9dc4e0df3d2a05"

@interface BXKViewController ()
<BXKAdvertDelegate>

@property (nonatomic, strong) id<BXKAdvertProtocol> advert;

@end

@implementation BXKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.advert = [BXKAdvertFactory createWithType:BXKAdvertTypeSearchBar comId:你的组件id delegate:self];    // 初始化广告
    [self.advert startRequest];    // 开始请求
}


#pragma mark - BXKAdvertDelegate

-(void)advert:(id<BXKAdvertProtocol>)advert didRequestSuccess:(NSDictionary *)response {
    if (advert.type == BXKAdvertTypeSearchBar) {
            // 显示广告
        // 推荐高度为110
        advert.view.frame = CGRectMake(0, 100, CGRectGetWidth(self.view.bounds), 110);
        [self.view addSubview:advert];
    }
}

- (void)advert:(id<BXKAdvertProtocol>)advert didRequestFailure:(NSError *)error {
    
}

-(void)advert:(id<BXKAdvertProtocol>)advert didClickWithLandingLink:(NSString *)landingLink {
        // 处理跳转逻辑
    BXKWebViewController *webVC = [[BXKWebViewController alloc] init];
    webVC.URLString = landingLink;
    [self.navigationController pushViewController:webVC animated:YES];
}

@end
```



## 弹窗组件

```objective-c
import "BXKViewController.h"
#import <BXKAdvertSDK/BXKAdvertSDK.h>
#import "BXKTestViewController.h"
#import "BXKWebViewController.h"

#define SDKKey     @"eebf41de"
#define SDKAppKey @"6a4188fa009807a30b9dc4e0df3d2a05"

@interface BXKViewController ()
<BXKAdvertDelegate>

@property (nonatomic, strong) id<BXKAdvertProtocol> advert;

@end

@implementation BXKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.advert = [BXKAdvertFactory createWithType:BXKAdvertTypePopUp comId:你的组件id delegate:self];    // 初始化广告
    [self.advert startRequest];    // 开始请求
}


#pragma mark - BXKAdvertDelegate

-(void)advert:(id<BXKAdvertProtocol>)advert didRequestSuccess:(NSDictionary *)response {
    if (advert.type == BXKAdvertTypePopUp) {
            // 弹窗组件在内部已将视图加载到keyWindow，这儿不需要处理
    }
}

- (void)advert:(id<BXKAdvertProtocol>)advert didRequestFailure:(NSError *)error {
    
}

-(void)advert:(id<BXKAdvertProtocol>)advert didClickWithLandingLink:(NSString *)landingLink {
    BXKWebViewController *webVC = [[BXKWebViewController alloc] init];
    webVC.URLString = landingLink;
    [self.navigationController pushViewController:webVC animated:YES];
}

@end
```



## 浮窗组件

```objective-c
import "BXKViewController.h"
#import <BXKAdvertSDK/BXKAdvertSDK.h>
#import "BXKTestViewController.h"
#import "BXKWebViewController.h"

#define SDKKey     @"eebf41de"
#define SDKAppKey @"6a4188fa009807a30b9dc4e0df3d2a05"

@interface BXKViewController ()
<BXKAdvertDelegate>

@property (nonatomic, strong) id<BXKAdvertProtocol> advert;

@end

@implementation BXKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.advert = [BXKAdvertFactory createWithType:BXKAdvertTypeFloater comId:你的组件id delegate:self];    // 初始化广告
    [self.advert startRequest];    // 开始请求
}


#pragma mark - BXKAdvertDelegate

-(void)advert:(id<BXKAdvertProtocol>)advert didRequestSuccess:(NSDictionary *)response {
    if (advert.type == BXKAdvertTypeFloater) {
            // 显示广告
        // 推荐宽高为114
          advert.view.frame = CGRectMake(200, 400, 114, 114);
        [self.view addSubview:advert.view];
    }
}

- (void)advert:(id<BXKAdvertProtocol>)advert didRequestFailure:(NSError *)error {
    
}

-(void)advert:(id<BXKAdvertProtocol>)advert didClickWithLandingLink:(NSString *)landingLink {
        // 处理跳转逻辑
    BXKWebViewController *webVC = [[BXKWebViewController alloc] init];
    webVC.URLString = landingLink;
    [self.navigationController pushViewController:webVC animated:YES];
}

@end
```

## 错误代码

|  错误码  | 说明                 |
| :------: | -------------------- |
| 88004001 | 请带上认证信息       |
| 88004002 | appkey不能为空       |
| 88004003 | 客户端信息不能为空   |
| 88004004 | appkey信息错误       |
| 88004005 | sign不能为空         |
| 88004006 | 签名错误             |
| 88004007 | 认证失败             |
|   602    | 系统异常，请联系技术 |
