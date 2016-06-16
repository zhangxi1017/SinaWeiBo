

//
//  NetRequst.m
//  SinaWeiBo
//
//  Created by ADAQM on 16/5/9.
//  Copyright © 2016年 ZGD. All rights reserved.
//

#import "NetRequst.h"
#import "AFNetworking.h"
#import "SubViewFrame.h"
#import "Status.h"
#import "HttpTool.h"
#import "Account.h"
#import "AccountTool.h"

@implementation NetRequst
/**
 *  首页数据
 */
+ (void)getHomeData:(DataBlock)response
{
    Account *account = [AccountTool account];
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
    paramsDic[@"access_token"] = account.access_token;
    [HttpTool getDataWithUrlStr:@"https://api.weibo.com/2/statuses/friends_timeline.json" params:paramsDic success:^(NSDictionary *data) {
        NSArray *statusArr = [NSArray array];
        statusArr = [Status objectArrayWithKeyValuesArray:data[@"statuses"]];
        NSMutableArray *frameArrM = [NSMutableArray array];
        for (Status *status in statusArr) {
            SubViewFrame *viewFrame = [[SubViewFrame alloc] init];
            viewFrame.statues = status;
            [frameArrM addObject:viewFrame];
        }
        response(frameArrM);
    } fail:^(NSError *error) {
        
    }];
}

@end
