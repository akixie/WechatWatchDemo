
//
//  WatchConnectivity.h
//  WechatWatchDemo
//
//  Created by akixie on 15/10/16.
//  Copyright © 2015年 Aki.Xie. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WatchConnectivityProtocol <NSObject>
/**
 *  WatchConnectivity 代理,接收数据后执行的方法
 *
 *  @param context 用户数据，数据类型为NSDictionary
 */
- (void)recievedNewContext:(NSDictionary *)context;

/**
 *  WatchConnectivity 代理,接收用户数据后执行的方法
 *
 *  @param userInfo 用户数据，数据类型为NSDictionary
 */
- (void)recievedUserInfo:(NSDictionary *)userInfo;


@end


@interface WatchConnectivity : NSObject

/**
 *  初始化
 *
 *  @return
 */
+ (instancetype)sharedInstance;
/**
 *  注册，激活，activateSession
 */
- (void)setup;
/**
 *  传送简单文本
 *
 *  @param context 数据类型为NSDictionary
 */
- (void)updateApplicationContext:(NSDictionary *)context;
/**
 *  传送用户数据
 *
 *  @param context 数据类型为NSDictionary
 */
- (void)transferUserInfo:(NSDictionary *)context ;
/**
 *  接收数据
 *
 *  @return 数据结果为NSDictionary
 */
- (NSDictionary *)receivedApplicationContext;

/**
 *WatchConnectivity 代理
 */
@property (nonatomic, weak) id<WatchConnectivityProtocol> delegate;

@end
