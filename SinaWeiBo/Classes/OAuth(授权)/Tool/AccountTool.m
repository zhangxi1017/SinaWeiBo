
//
//  AccountTool.m
//  SinaWeiBo
//
//  Created by ADAQM on 16/5/8.
//  Copyright © 2016年 ZGD. All rights reserved.
//

#import "AccountTool.h"
#define AccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]
@implementation AccountTool

+ (void)saveAccount:(Account *)account
{
    account.created_time = [NSDate date];
    
    [NSKeyedArchiver archiveRootObject:account toFile:AccountPath];
    
}

+ (Account *)account
{
    Account *account = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountPath];
    
    long long expires_in = [account.expires_in longLongValue];
    // 获得过期时间
    NSDate *expiresTime = [account.created_time dateByAddingTimeInterval:expires_in];
    // 获得当前时间
//    NSLog(@"过期时间%@",expiresTime);
    NSDate *now = [NSDate date];
//    NSLog(@"现在的时间%@",now);
    // 如果expiresTime <= now，过期
    /**
     NSOrderedAscending = -1L, 升序，右边 > 左边
     NSOrderedSame, 一样
     NSOrderedDescending 降序，右边 < 左边
     */
    NSComparisonResult result = [expiresTime compare:now];
    if (result != NSOrderedDescending) { // 过期
        return nil;
    }
    NSLog(@"%@",account.access_token);
    return account;
}

@end
