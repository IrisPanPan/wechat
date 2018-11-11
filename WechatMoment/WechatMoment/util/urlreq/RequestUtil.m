//
//  RequestUtil.m
//  WechatMoment
//
//  Created by panh on 2018/11/10.
//  Copyright © 2018 ph. All rights reserved.
//

#import "RequestUtil.h"
#import <AFNetworking.h>
@implementation RequestUtil

+(void)sendRequestToServer:(NSString *)url Parameters:(NSDictionary *)params TimeOut:(int)timeOutSeconds Success:(void (^)(id result))success    Fail:(void (^)(NSString *result))fail{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    /* 设置请求和接收的数据编码格式 */
    session.requestSerializer = [AFJSONRequestSerializer serializer]; // 设置请求数据为 JSON 数据
    session.responseSerializer = [AFJSONResponseSerializer serializer]; // 设置接收数据为 JSON 数据
    session.requestSerializer.timeoutInterval = timeOutSeconds;
    /* 设置请求头 */
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", @"text/plain", nil];
   
  //  [session.requestSerializer setValue:@"xxx" forHTTPHeaderField:@"xxx"];
    
    [session GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success){
            success(responseObject);
        }
        NSLog(@"成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败");
    }];
}



+(void)uploadFileToServer:(NSString *)url Parameters:(NSDictionary *)params FilePath:(NSString *)filePath Success:(void (^)(NSDictionary *successDic))success    Fail:(void (^)(NSDictionary *failDic))fail{
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    [sessionManager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        ;
        NSData *imgData = [NSData dataWithContentsOfFile:filePath];
        
        [formData appendPartWithFileData:imgData name:@"pic" fileName:@"filename" mimeType:@"image/jpg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        // 获取上传的进度
        NSLog(@"%.2f",uploadProgress.fractionCompleted);
        NSLog(@"线程：%@",[NSThread currentThread]); // 子线程
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 请求成功
        NSLog(@"请求成功：%@",responseObject);
        NSLog(@"线程：%@",[NSThread currentThread]); // 主线程
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        NSLog(@"请求失败：%@",error);
    }];
    
}



+(void)downloadFileFromServer:(NSString *)urlStr DesPath:(NSString *)desPath Completion:(void (^)(NSString *result))comletion{
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfig.timeoutIntervalForRequest = 10;
    //sessionConfig.timeoutIntervalForResource = 30;
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:sessionConfig];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSString *filePath = [desPath stringByAppendingPathComponent:url.lastPathComponent];
  
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        NSLog(@"下载进度：%.0f％", downloadProgress.fractionCompleted * 100);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {

        return [NSURL fileURLWithPath:filePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSString * urlStr = [filePath absoluteString];
        comletion(urlStr);
        //NSLog(@"下载完成");
        
    }];
    
    [downloadTask resume];
}


+(void)startListenNetworkStatus{
    
    //1.创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];

    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //这里是监测到网络改变的block  可以写成switch方便
        //在里面可以随便写事件
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                isNetConnect = NO;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                isNetConnect = NO;
                //WKNSLog(@"无网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                isNetConnect = YES;
                //WKNSLog(@"蜂窝数据网");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                isNetConnect = YES;
                //WKNSLog(@"WiFi网络");
                
                break;
                
            default:
                break;
        }
        
    }] ;
}
@end
