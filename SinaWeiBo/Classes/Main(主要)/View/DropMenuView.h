//
//  DropMenuView.h
//  SinaWeiBo
//
//  Created by ADAQM on 16/4/25.
//  Copyright © 2016年 ZGD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DropMenuView;
@protocol DropMenuViewDelegate <NSObject>

- (void)dismiss:(DropMenuView *)view;

- (void)show:(DropMenuView *)view;

@end

@interface DropMenuView : UIView

- (void)showFrom:(UIView *)view;

- (void)dismiss;

@property(nonatomic,strong)UIView *contentView;

@property(nonatomic,strong)UIViewController *contentVC;

+ (instancetype)menu;

@property(nonatomic,weak)id<DropMenuViewDelegate> delegate;

@end
