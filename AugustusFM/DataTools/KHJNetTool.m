//
//  KHJNetTool.m
//  AugustusFM
//
//  Created by dllo on 16/7/13.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJNetTool.h"
#import "AFNetworking.h"
@implementation KHJNetTool
+ (void)GET:(NSString *)url body:(id)body headerFile:(NSDictionary *)headers response:(KHJResponseStyle)responseStyle success:(successBlock)success failure:(failureBlock)failure{
    //1.设置网络管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2.设置请求头
    if (headers) {
        for (NSString *key in headers.allKeys) {
            [manager.requestSerializer setValue:headers[key] forHTTPHeaderField:key];
        }
    }
    //创建返回值类型
    switch (responseStyle) {
        case KHJJSON:
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        case KHJXML:
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        case KHJDATA:
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        default:
            break;
    }
    //4.设置响应类型
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", @"application/javascript",@"image/jpeg", @"text/vnd.wap.wml", nil]];
    //5.UTF8转码
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //6.使用AFN进行网络请求
    [manager GET:url parameters:body progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
             success(responseObject);
        }
    } failure:
^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    if (error) {
        failure(error);
    }
    
}];
}

+ (void)POST:(NSString *)url body:(id)body bodyStyle:(KHJRequestStyle)bodyStyle headerFile:(NSDictionary *)headers response:(KHJResponseStyle)responseStyle success:(successBlock)success failure:(failureBlock)failure{
    //1.设置网络管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2.设置body 数据类型
    switch (bodyStyle) {
        case KHJBodyJSON:
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            break;
        case KHJBodyString:
            [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString * _Nonnull(NSURLRequest * _Nonnull request, id  _Nonnull parameters, NSError * _Nullable * _Nullable error) {
                return parameters;
            }];
            break;
        default:
            break;
    }
    //3.设置请求头
    if (headers) {
        for (NSString *key in headers.allKeys) {
            [manager.requestSerializer setValue:headers[key] forHTTPHeaderField:key];
        }
    }
    //创建返回值类型
    switch (responseStyle) {
        case KHJJSON:
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        case KHJXML:
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        case KHJDATA:
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        default:
            break;
    }
    //4.设置响应类型
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", @"application/javascript",@"image/jpeg", @"text/vnd.wap.wml", nil]];
    //5.UTF8转码
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //6.使用AFN进行网络请求
    [manager POST:url parameters:body progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            success(responseObject);
        }
    } failure:
     ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         if (error) {
             failure(error);
         }
         
     }];

    
}


@end
