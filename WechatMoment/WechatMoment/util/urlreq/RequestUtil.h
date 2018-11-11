//
//  RequestUtil.h
//  WechatMoment
//
//  Created by panh on 2018/11/10.
//  Copyright © 2018 ph. All rights reserved.
//

#import <Foundation/Foundation.h>



NS_ASSUME_NONNULL_BEGIN

//网络请求 返回结果标记
typedef NS_ENUM(NSUInteger, RequestFlag) {
    RequestUrlError,//请求地址错误
    RequestParamError,//请求参数错误
    RequestTimeOut,//请求超时
    RequsetFail,//请求失败
    RequestSuccess//请求成功
};

@interface RequestUtil : NSObject
+(void)startListenNetworkStatus;

+(void)sendRequestToServer:(NSString *)url Parameters:(NSDictionary *)params TimeOut:(int)timeOutSeconds Success:(void (^)(id result))success    Fail:(void (^)(NSString *result))fail;

+(void)downloadFileFromServer:(NSString *)urlStr DesPath:(NSString *)desPath Completion:(void (^)(NSString *result))comletion;
@end

NS_ASSUME_NONNULL_END
