//
//  ComposeViewController.m
//  SinaWeiBo
//
//  Created by ADAQM on 16/6/16.
//  Copyright © 2016年 ZGD. All rights reserved.
//

#import "ComposeViewController.h"
#import "ZGDTextView.h"
@interface ComposeViewController ()
@property(nonatomic,strong)UIButton *rightBtn;
@property(nonatomic,strong)ZGDTextView *textView;
@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNav];
    /**
     *  添加输入框
     */
    [self addTextView];
}
#pragma mark - 添加输入框
- (void)addTextView
{
    self.textView = [[ZGDTextView alloc] initWithFrame:self.view.bounds];
    self.textView.placeholder = @"我若成魔,佛奈我何。我若成佛,天下无魔。";
    self.textView.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:self.textView];
    [ZGDNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self.textView];
}
- (void)textDidChange
{
    self.rightBtn.enabled = self.textView.hasText;
    if (self.textView.hasText) {
        [self.rightBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    }else
    {
        [self.rightBtn setTitleColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.7] forState:UIControlStateNormal];
    }
}

/**
 * 设置导航栏内容
 */
- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(leftAction)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
//    self.navigationItem.rightBarButtonItem.enabled = NO;
//    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
//    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.7];
//    
//    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:disableTextAttrs forState:UIControlStateNormal];
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn.frame = CGRectMake(0, 0, 60, 30);
    [self.rightBtn setTitle:@"发送" forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.7] forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    self.rightBtn.enabled = NO;
    [self.rightBtn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
}

- (void)leftAction
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)send
{
    NSLog(@"send发送");
}
@end
