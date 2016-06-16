
//
//  NSString+Extension.m
//  SinaWeiBo
//
//  Created by ADAQM on 16/5/19.
//  Copyright © 2016年 ZGD. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
- (CGSize)sizeWithText:(NSString *)text fontSize:(CGFloat)size
{
    NSMutableDictionary *dicM = [NSMutableDictionary dictionary];
    dicM[NSFontAttributeName] = [UIFont systemFontOfSize:size];
    CGRect textRect = [text boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dicM context:nil];
    return textRect.size;
}
@end
