//
//  User.m
//  SinaWeiBo
//
//  Created by ADAQM on 16/5/9.
//  Copyright © 2016年 ZGD. All rights reserved.
//

#import "User.h"

@implementation User
- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    
    self.vip = mbtype > 2;
}
@end
