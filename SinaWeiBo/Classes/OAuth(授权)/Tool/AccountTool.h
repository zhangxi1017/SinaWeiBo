//
//  AccountTool.h
//  SinaWeiBo
//
//  Created by ADAQM on 16/5/8.
//  Copyright © 2016年 ZGD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"
@interface AccountTool : NSObject
/**
 *  存储账号信息
 */

+ (void)saveAccount:(Account *)account;
/**
 *  返回账号信息
 *
 *  @return 账号模型（如果账号过期，返回nil）
 */
+ (Account *)account;
@end
