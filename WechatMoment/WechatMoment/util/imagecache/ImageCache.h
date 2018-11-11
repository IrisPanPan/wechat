//
//  ImageCache.h
//  WechatMoment
//
//  Created by panh on 2018/11/8.
//  Copyright © 2018 ph. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface ImageCache : NSObject
@property (strong, nonatomic) NSString *diskCachePath;//磁盘缓存地址
+ (ImageCache *)sharedImageCache;

//保存图片到内存
-(void)saveImageToCathe:(UIImage *)image Url:(NSString *)urlStr;

//内存中获取图片
-(UIImage *)getImageFromCacheByUrl:(NSString *)urlStr;

//清空内存
-(void)clearAllMemCache;

//从磁盘中获取图片
-(UIImage *)getImageFromDisk:(NSString *)urlStr;

//保存图片到磁盘
-(void)saveImageOnDisk:(UIImage *)image Url:(NSString *)urlStr;

//清空磁盘
- (void)clearDisk;
@end

NS_ASSUME_NONNULL_END
