//
//  HttpTool.h
//  SinaWeiBo
//
//  Created by ADAQM on 16/5/19.
//  Copyright © 2016年 ZGD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
typedef void(^Complete)(id data);
typedef void (^Fail)(NSError *error);
@interface HttpTool : NSObject
/**
 *  GET
 */
+ (void)getDataWithUrlStr:(NSString *)urlStr params:(NSDictionary *)params success:(Complete)complete fail:(Fail)fail;
@end
