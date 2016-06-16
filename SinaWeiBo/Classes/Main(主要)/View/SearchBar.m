//
//  SearchBar.m
//  SinaWeiBo
//
//  Created by ADAQM on 16/4/25.
//  Copyright © 2016年 ZGD. All rights reserved.
//

#import "SearchBar.h"

@implementation SearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:15];
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        self.placeholder = @"请输入搜索条件";
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        imgView.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        imgView.contentMode = UIViewContentModeCenter;
        self.leftView = imgView;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

+ (instancetype)searchBar
{
    return [[self alloc]init];
}

@end
