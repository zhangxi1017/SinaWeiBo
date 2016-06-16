//
//  UIWindow+Extension.m
//  SinaWeiBo
//
//  Created by ADAQM on 16/5/8.
//  Copyright © 2016年 ZGD. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "HWTabBarViewController.h"
#import "NewFeatureViewController.h"

@implementation UIWindow (Extension)
- (void)switchRootViewController
{
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"CFBundleVersion"];
    
    NSString *currentVersion = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleVersion"];
    
    if ([lastVersion isEqualToString:currentVersion]) {
        HWTabBarViewController *mainTabbar = [HWTabBarViewController new];
        self.rootViewController = mainTabbar;
    }else
    {
        self.rootViewController = [NewFeatureViewController new];
        [[NSUserDefaults standardUserDefaults] setValue:currentVersion forKey:@"CFBundleVersion"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
@end
