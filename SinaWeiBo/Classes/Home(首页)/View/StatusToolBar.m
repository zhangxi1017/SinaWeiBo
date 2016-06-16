
//
//  StatusToolBar.m
//  SinaWeiBo
//
//  Created by ADAQM on 16/5/26.
//  Copyright © 2016年 ZGD. All rights reserved.
//

#import "StatusToolBar.h"
#import "Status.h"

@interface StatusToolBar ()

@property (nonatomic, strong) UIButton *repostBtn;
@property (nonatomic, strong) UIButton *commentBtn;
@property (nonatomic, strong) UIButton *attitudeBtn;
@property(nonatomic,strong)NSMutableArray *buttonArrM;
@property(nonatomic,strong)NSMutableArray *dividers;
@end

@implementation StatusToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.buttonArrM = [NSMutableArray array];
        self.backgroundColor = [UIColor orangeColor];
        self.repostBtn = [self setButtonWithTitle:self.repostBtn withTile:@"转发" withImageName:@"timeline_icon_retweet"];
        [self.repostBtn addTarget:self action:@selector(repostAction) forControlEvents:UIControlEventTouchUpInside];
        self.commentBtn = [self setButtonWithTitle:self.commentBtn withTile:@"评论" withImageName:@"timeline_icon_comment"];
        [self.commentBtn addTarget:self action:@selector(commentAction) forControlEvents:UIControlEventTouchUpInside];
        self.attitudeBtn = [self setButtonWithTitle:self.attitudeBtn withTile:@"点赞" withImageName:@"timeline_icon_unlike"];
        [self.attitudeBtn addTarget:self action:@selector(attitudeAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        [self setupDivider];
        [self setupDivider];
        
    }
    return self;
}
/**
 *  分割线
 */
- (NSMutableArray *)dividers
{
    if (_dividers == nil) {
        _dividers = [NSMutableArray array];
    }
    return _dividers;
}
- (void)setupDivider
{
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:imgView];
    [self.dividers addObject:imgView];
}
/**
 *  转发
 */
- (void)repostAction
{
  NSLog(@"%@",self.status.user.name);
}
/**
 *  评论
 */
- (void)commentAction
{
    NSLog(@"%@",self.status.user.name);
}
/**
 *  点赞
 */
- (void)attitudeAction
{
   NSLog(@"%@",self.status.user.name);
}
- (UIButton *)setButtonWithTitle:(UIButton *)button withTile:(NSString *)title withImageName:(NSString *)imgName
{
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [self addSubview:button];
    [self.buttonArrM addObject:button];
    return button;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat buttonW = self.width / self.buttonArrM.count;
    CGFloat buttonH = self.height;
    for (NSInteger i = 0; i < self.buttonArrM.count; i ++) {
        UIButton *button = self.buttonArrM[i];
        button.frame = CGRectMake(buttonW * i, 0, buttonW, buttonH);
    }
    
    
    //分割线
    for (NSInteger i = 0; i < self.dividers.count; i ++) {
        UIImageView *imgView = self.dividers[i];
        imgView.frame = CGRectMake((i + 1) * buttonW, 0, 1, buttonH);
    }
    
}
- (void)setStatus:(Status *)status
{
    _status = status;
    [self setupBtnCount:status.reposts_count btn:self.repostBtn title:@"转发"];
    [self setupBtnCount:status.comments_count btn:self.commentBtn title:@"评论"];
    [self setupBtnCount:status.attitudes_count btn:self.attitudeBtn title:@"点赞"];
    [self setNeedsLayout];
}
- (void)setupBtnCount:(NSInteger)count btn:(UIButton *)btn title:(NSString *)title
{
    if (count) {
        if (count < 10000) {
            title = [NSString stringWithFormat:@"%ld",count];
        }else
        {
            double wan = count / 10000.0;
            title = [NSString stringWithFormat:@"%f",wan];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
    }else
    {
        
    }
    [btn setTitle:title forState:UIControlStateNormal];
}

@end
