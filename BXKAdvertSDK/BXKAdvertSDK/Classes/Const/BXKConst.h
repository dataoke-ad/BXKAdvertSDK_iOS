//
//  BXKConst.h
//  Pods
//
//  Created by wit on 2020/8/24.
//

#ifndef BXKConst_h
#define BXKConst_h

#define BXKDomain   @"com.dataoke.BXKAdvertSDK"

typedef NS_ENUM(NSInteger, BXKAdvertSDKErrorCode) {
    BXKAdvertSDKErrorCodeNone = 600,    // 未知错误
    BXKAdvertSDKErrorCodeComId = 601,   // 组件id为空
    BXKAdvertSDKErrorCodeService = 602, // 服务器错误
};

typedef NS_ENUM(NSUInteger, BXKAdvertType) {
    BXKAdvertTypeStartupScreen = 1, // 开屏广告
    BXKAdvertTypeInfoFlow,          // 信息流组件
    BXKAdvertTypeSearchBar,         // 优惠券搜索器组件
    BXKAdvertTypePopUp,             // 弹窗组件
    BXKAdvertTypeFloater,           // 浮窗组件
};

#endif /* BXKConst_h */
