//
//  NetRequst.h
//  SinaWeiBo
//
//  Created by ADAQM on 16/5/9.
//  Copyright © 2016年 ZGD. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^DataBlock)(id data);
@interface NetRequst : NSObject
/**
 *  得到首页数据
 */
+ (void)getHomeData:(DataBlock)response;

@end
