
//
//  HttpTool.m
//  SinaWeiBo
//
//  Created by ADAQM on 16/5/19.
//  Copyright © 2016年 ZGD. All rights reserved.
//

#import "HttpTool.h"

@implementation HttpTool
+ (void)getDataWithUrlStr:(NSString *)urlStr params:(NSDictionary *)params success:(Complete)complete fail:(Fail)fail
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr GET:urlStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        complete(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
@end
