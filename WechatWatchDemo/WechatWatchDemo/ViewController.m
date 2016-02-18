//
//  ViewController.m
//  WechatWatchDemo
//
//  Created by akixie on 15/10/16.
//  Copyright © 2015年 Aki.Xie. All rights reserved.
//

#import "ViewController.h"
#import "WatchConnectivity.h"

@interface ViewController ()<WatchConnectivityProtocol>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //watch os
    [WatchConnectivity sharedInstance].delegate = self;
    
    
    //发送数据到apple watch
    [[WatchConnectivity sharedInstance] transferUserInfo:@{
                                                           @"watchMessageText" : @"hello watch!"
                                                           
                                                           }];
    [[WatchConnectivity sharedInstance] updateApplicationContext:@{
                                                                   @"watchMessageText" : @"hello watch!"
                                                                   }];
}

//接收apple watch数据
#pragma mark - <WatchConnectivityProtocol>
- (void)recievedNewContext:(NSDictionary *)context {
    NSString *messageText = [context objectForKey:@"messageText"];

    
    
}

- (void)recievedUserInfo:(NSDictionary *)userInfo{
    NSString *messageText = [userInfo objectForKey:@"messageText"];
    //
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
