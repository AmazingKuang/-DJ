//
//  KHJNetTool.h
//  AugustusFM
//
//  Created by dllo on 16/7/13.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^successBlock)(id result);
typedef void(^failureBlock)(NSError *error);
typedef NS_ENUM(NSUInteger, KHJResponseStyle) {
    KHJJSON,
    KHJDATA,
    KHJXML,
};

typedef NS_ENUM(NSUInteger, KHJRequestStyle) {
    KHJBodyString,
    KHJBodyJSON,
};


@interface KHJNetTool : NSObject
+ (void)GET:(NSString *)url
       body:(id)body
 headerFile:(NSDictionary *)headers
   response:(KHJResponseStyle)responseStyle
    success:(successBlock)success
    failure:(failureBlock)failure;

+ (void)POST:(NSString *)url
        body:(id)body
   bodyStyle:(KHJRequestStyle)bodyStyle
  headerFile:(NSDictionary *)headers
    response:(KHJResponseStyle)responseStyle
     success:(successBlock)success
     failure:(failureBlock)failure;

@end
