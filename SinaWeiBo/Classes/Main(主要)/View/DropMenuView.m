//
//  DropMenuView.m
//  SinaWeiBo
//
//  Created by ADAQM on 16/4/25.
//  Copyright © 2016年 ZGD. All rights reserved.
//

#import "DropMenuView.h"

@interface DropMenuView()

@property(nonatomic,strong)UIImageView *containerView;

@end

@implementation DropMenuView


- (UIImageView *)containerView
{
    if (_containerView == nil) {
        _containerView = [[UIImageView alloc] init];
        _containerView.image = [UIImage imageNamed:@"popover_background"];
//        _containerView.width = 217;
//        _containerView.height = 30;

        _containerView.userInteractionEnabled = YES;
        [self addSubview:_containerView];
    }
    return _containerView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)showFrom:(UIView *)view
{
    UIWindow *window = [[[UIApplication sharedApplication] windows]lastObject];
    self.frame = window.bounds;
    [window addSubview:self];
    [self.delegate show:self];
    CGRect newRect = [view convertRect:view.bounds toView:window];
    self.containerView.centerX = CGRectGetMidX(newRect);
    self.containerView.y = CGRectGetMaxY(newRect) + 3;
}

- (void)setContentView:(UIView *)contentView
{
    _contentView = contentView;
    
    contentView.x = 10;
    contentView.y = 15;
    
    self.containerView.width = CGRectGetMaxX(contentView.frame) + 10;
    self.containerView.height = CGRectGetMaxY(contentView.frame) + 10;
    [self.containerView addSubview:contentView];
}

- (void)setContentVC:(UIViewController *)contentVC
{
    _contentVC = contentVC;
    self.contentView = contentVC.view;
}



- (void)dismiss
{
    [self.delegate dismiss:self];
    [self removeFromSuperview];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}

+ (instancetype)menu
{
    return [[self alloc] init];
}

@end
