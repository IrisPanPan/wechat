//
//  ImageMgr.h
//  WechatMoment
//  图片管理器
//  Created by panh on 2018/11/8.
//  Copyright © 2018 ph. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "ImageCache.h"
#import "ImageDownloader.h"

NS_ASSUME_NONNULL_BEGIN


typedef void(^ImageCompletionBlock)(UIImage *image,NSString *imageURL);


@interface ImageMgr : NSObject

@property (strong, nonatomic, readonly) ImageCache *imageCache;
@property (strong, nonatomic, readonly) ImageDownloader *imageDownloader;

/**
 @return 图片管理实例
 */
+ (ImageMgr *)sharedManager;



/**
 下载图片

 @param url 图片下载地址
 @param completedBlock 图片下载完成
 */
- (void)downloadImageWithURL:(NSString *)url PlaceHolderImgName:(NSString *)placeholder  completed:(ImageCompletionBlock)completedBlock;
@end

NS_ASSUME_NONNULL_END
