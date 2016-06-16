//
//  ZGDTextView.m
//  SinaWeiBo
//
//  Created by ADAQM on 16/6/16.
//  Copyright © 2016年 ZGD. All rights reserved.
//

#import "ZGDTextView.h"

@implementation ZGDTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)textDidChange
{
    [self setNeedsDisplay];
}
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    [self setNeedsDisplay];
}
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}
- (void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect
{
    if (self.hasText) {
        return;
    }else
    {
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSFontAttributeName] = self.font;
        attrs[NSForegroundColorAttributeName] = self.placeholderColor?self.placeholderColor:[UIColor grayColor];
        CGFloat x = 5;
        CGFloat w = rect.size.width - 2 * x;
        CGFloat y = 8;
        CGFloat h = rect.size.height - 2 * y;
        CGRect placeholderRect = CGRectMake(x, y, w, h);
        [self.placeholder drawInRect:placeholderRect withAttributes:attrs];
    }

}



@end
