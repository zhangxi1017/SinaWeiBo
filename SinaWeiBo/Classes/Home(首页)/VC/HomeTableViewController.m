//
//  HomeTableViewController.m
//  SinaWeiBo
//
//  Created by ADAQM on 16/4/20.
//  Copyright © 2016年 ZGD. All rights reserved.
//

#import "HomeTableViewController.h"
#import "HahaViewController.h"
#import "DropMenuView.h"
#import "AFNetworking.h"
#import "AccountTool.h"
#import "Account.h"
#import "TitleBtn.h"
#import "Status.h"
#import "HomeTableViewCell.h"
#import "SubViewFrame.h"
#import "NetRequst.h"


@interface HomeTableViewController ()<DropMenuViewDelegate>
@property(nonatomic,strong)TitleBtn *titleButton;
@property(nonatomic,strong)NSArray *statusArr;
@property(nonatomic,strong)NSMutableArray *frameArr;
@end

@implementation HomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    // 获得用户信息（昵称）
    [self setupUserInfo];
    //获取微博信息
    [self lodaData];
    /**
     *  下拉刷新
     */
    [self setupDownRefresh];
    
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}
- (void)timeAction
{
    NSLog(@"好使不?");
}
/**
 *  集成下拉刷新控件
 */
- (void)setupDownRefresh
{
    UIRefreshControl *control = [[UIRefreshControl alloc] init];
    [control addTarget:self action:@selector(loadNewStatus:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:control];
    [control beginRefreshing];
    // 3.马上加载数据
    [self loadNewStatus:control];
}
- (void)loadNewStatus:(UIRefreshControl *)control
{
    // 1.请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];

    // 2.拼接请求参数
    Account *account = [AccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    SubViewFrame *firstStatusF = [self.frameArr firstObject];
    if (firstStatusF) {
        params[@"since_id"] = firstStatusF.statues.idstr;
    }
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json"  parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *newStatus = [Status objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        NSArray *newFrames = [self stausFramesWithStatuses:newStatus];
        NSRange range = NSMakeRange(0, newFrames.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.frameArr insertObjects:newFrames atIndexes:set];
        [self.tableView reloadData];
        [control endRefreshing];
        [self showNewStatusCount:newFrames.count];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
- (void)showNewStatusCount:(int)count
{
    self.tabBarItem.badgeValue = nil;
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.width = self.view.width;
    label.height = 30;
    label.x = 0;
    label.y = 64 - label.height;
    // 2.设置其他属性
    if (count == 0) {
        label.text = @"没有新的微博数据，稍后再试";
    } else {
        label.text = [NSString stringWithFormat:@"共有%d条新的微博数据", count];
    }
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
        [UIView animateWithDuration:1 animations:^{
//            label.y = self.navigationController.navigationBar.bottom;
            label.transform = CGAffineTransformMakeTranslation(0, label.height);
        }completion:^(BOOL finished) {
            // 延迟1s后，再利用1s的时间，让label往上移动一段距离（回到一开始的状态）
            CGFloat delay = 1.0; // 延迟1s
            // UIViewAnimationOptionCurveLinear:匀速
            [UIView animateWithDuration:1 delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
                label.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                [label removeFromSuperview];
            }];
        }];
    
    
}
/**
 *  将HWStatus模型转为HWStatusFrame模型
 */
- (NSArray *)stausFramesWithStatuses:(NSArray *)statuses
{
    NSMutableArray *frames = [NSMutableArray array];
    for (Status *status in statuses) {
        SubViewFrame *f = [[SubViewFrame alloc] init];
        f.statues = status;
        [frames addObject:f];
    }
    return frames;
}
/**
 *  获取微博信息
 *
 *  @return <#return value description#>
 */
- (void)lodaData
{
    
    [NetRequst getHomeData:^(NSMutableArray *data) {
        self.frameArr = [NSMutableArray array];
        self.frameArr = data;
        [self.tableView reloadData];
    }];
}


/**
 *  获得用户信息（昵称）
 */
- (void)setupUserInfo
{
    
    Account *account = [AccountTool account];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
        
        NSString *name = [responseObject objectForKey:@"name"];
        [self.titleButton setTitle:name ? name:@"首页" forState:UIControlStateNormal];
        account.name = name;
        [AccountTool saveAccount:account];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
- (void)setNav
{
    self.view.backgroundColor = ZGDRandomColor;
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendSearch:) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
    
    self.titleButton = [TitleBtn buttonWithType:UIButtonTypeCustom];

    
    [self.titleButton addTarget:self action:@selector(titleAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = self.titleButton;
}

- (void)titleAction:(UIButton *)btn
{
//    btn.selected = !btn.isSelected;
    DropMenuView *menu = [DropMenuView menu];
    menu.delegate = self;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 100)];
    
    view.backgroundColor = [UIColor whiteColor];
    menu.contentView = view;
    
    [menu showFrom:btn];
   
}

#pragma mark - DropMenuViewDelegate
- (void)show:(DropMenuView *)view
{
    TitleBtn *titleButton = (TitleBtn *)self.navigationItem.titleView;
    titleButton.selected = NO;
}
- (void)dismiss:(DropMenuView *)view
{
    TitleBtn *titleButton = (TitleBtn *)self.navigationItem.titleView;
    titleButton.selected = YES;
}

- (void)friendSearch:(UIButton *)btn
{
    NSLog(@"friendSearch");
    
}

- (void)pop
{
     NSLog(@"pop");
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.frameArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifier = @"cell";
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[HomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }

    cell.viewFrame = self.frameArr[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   SubViewFrame *viewframe = self.frameArr[indexPath.row];
    return viewframe.cellHeight;
}



@end
