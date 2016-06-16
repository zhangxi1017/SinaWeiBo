
//
//  Status.m
//  SinaWeiBo
//
//  Created by ADAQM on 16/5/9.
//  Copyright © 2016年 ZGD. All rights reserved.
//

#import "Status.h"
#import "Photo.h"

@implementation Status
- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [Photo class]};
}

- (NSString *)created_at
{
    return _created_at;
}

@end
