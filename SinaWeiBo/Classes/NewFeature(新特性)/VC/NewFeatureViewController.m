//
//  NewFeatureViewController.m
//  SinaWeiBo
//
//  Created by ADAQM on 16/5/4.
//  Copyright © 2016年 ZGD. All rights reserved.
//

#import "NewFeatureViewController.h"
#import "HWTabBarViewController.h"


@interface NewFeatureViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,strong)UIPageControl *pageControl;

@property(nonatomic,strong)UIButton *shareBtn;

@property(nonatomic,strong)UIButton *startBtn;
@end

@implementation NewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    //添加图片
    for (NSInteger i = 0; i < 4; i ++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.view.width, 0, self.view.width, self.view.height)];
        imgView.userInteractionEnabled = YES;
        imgView.backgroundColor = ZGDRandomColor;
        NSString *name = [NSString stringWithFormat:@"new_feature_%d", i + 1];
        imgView.image = [UIImage imageNamed:name];
        [self.scrollView addSubview:imgView];
        if (i == 3) {
            self.shareBtn.centerX = imgView.width * .5;
            self.shareBtn.centerY = imgView.height * 0.65;
            [imgView addSubview:self.shareBtn];
            self.startBtn.centerY = self.view.height * 0.75;
            [imgView addSubview:self.startBtn];
        }
    }
    self.pageControl.currentPage = 0;
}

- (UIButton *)shareBtn
{
    if (_shareBtn == nil) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareBtn.width = 200;
        _shareBtn.height = 30;
        [_shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
        [_shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
        [_shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
        [_shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _shareBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        [_shareBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        _startBtn.centerX = self.shareBtn.centerX;
        
        [self.view addSubview:_shareBtn];
    }
    return _shareBtn;
}
- (void)btnAction:(UIButton *)btn
{
    btn.selected = !btn.isSelected;
}
- (UIPageControl *)pageControl
{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.numberOfPages = 4;
        CGSize size = [_pageControl sizeForNumberOfPages:4];
        _pageControl.width = size.width;
        _pageControl.height = size.height;
        _pageControl.y = self.view.height - 60;
        _pageControl.x = (self.view.width - size.width) * .5;
        _pageControl.currentPageIndicatorTintColor = [UIColor purpleColor];
        _pageControl.pageIndicatorTintColor = [UIColor orangeColor];
        [self.view addSubview:_pageControl];
    }
    return _pageControl;
}
- (UIButton *)startBtn
{
    if (_startBtn == nil) {
        _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
        [_startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
        _startBtn.titleLabel.font = [UIFont systemFontOfSize:19];
        _startBtn.size = _startBtn.currentBackgroundImage.size;
        _startBtn.centerX = self.shareBtn.centerX;
        [_startBtn addTarget:self action:@selector(startAction) forControlEvents:UIControlEventTouchUpInside];
        [_startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    }
    return _startBtn;
}
- (void)startAction
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [HWTabBarViewController new];
}


- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.contentSize = CGSizeMake(self.view.width * 4, self.view.height);
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double currentPage = scrollView.contentOffset.x / self.view.width;
    self.pageControl.currentPage = (int)(currentPage + 0.5);
}
@end
