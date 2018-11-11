//
//  ImageDownloader.m
//  WechatMoment
//
//  Created by panh on 2018/11/8.
//  Copyright © 2018 ph. All rights reserved.
//

#import "ImageDownloader.h"

@implementation ImageDownloader

+ (ImageDownloader *)sharedDownloader {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}





@end
