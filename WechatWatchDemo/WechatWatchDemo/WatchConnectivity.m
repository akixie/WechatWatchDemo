//
//  WatchConnectivity.m
//  WechatWatchDemo
//
//  Created by akixie on 15/10/16.
//  Copyright © 2015年 Aki.Xie. All rights reserved.
//

#import <WatchConnectivity/WatchConnectivity.h>
#import "WatchConnectivity.h"

@interface WatchConnectivity () <WCSessionDelegate>
@end

@implementation WatchConnectivity

+ (instancetype)sharedInstance {
    static WatchConnectivity *sharedInstance;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        sharedInstance = [WatchConnectivity new];
    });
    return sharedInstance;
}

- (void)setup {
    WCSession *session = [WCSession defaultSession];
    session.delegate = self;
    [session activateSession];
}

- (void)updateApplicationContext:(NSDictionary *)context {
    NSError *error;
    WCSession *session = [WCSession defaultSession];
    [session updateApplicationContext:context error:&error];
}

//发送消息给watch
- (void)transferUserInfo:(NSDictionary *)context {
    WCSession *session = [WCSession defaultSession];
    [session transferUserInfo:context];
}

- (NSDictionary *)receivedApplicationContext {
    WCSession *session = [WCSession defaultSession];
    return session.receivedApplicationContext;
}




#pragma mark - <WCSessionDelegate>
- (void)session:(WCSession *)session didReceiveApplicationContext:(NSDictionary<NSString *,id> *)applicationContext {
    if ([self.delegate conformsToProtocol:@protocol(WatchConnectivityProtocol)]) {
        [self.delegate recievedNewContext:applicationContext];
    }
}

- (void)session:(WCSession *)session didReceiveUserInfo:(NSDictionary<NSString *, id> *)userInfo{
    if ([self.delegate conformsToProtocol:@protocol(WatchConnectivityProtocol)]) {
        [self.delegate recievedUserInfo:userInfo];
    }
}


@end
