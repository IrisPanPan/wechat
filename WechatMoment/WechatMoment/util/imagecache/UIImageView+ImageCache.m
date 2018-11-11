//
//  UIImageView+ImageCache.m
//  WechatMoment
//
//  Created by panh on 2018/11/9.
//  Copyright © 2018 ph. All rights reserved.
//

#import "UIImageView+ImageCache.h"
#import "objc/runtime.h"
#import "ImageMgr.h"

@implementation UIImageView (ImageCache)


-(void)setImageWithURL:(NSString *)url placeholderImage:(NSString *)placeholder competed:(ImageCompletionBlock)completedBlock{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{ // 处理耗时操作在此次添加
        [[ImageMgr sharedManager] downloadImageWithURL:url PlaceHolderImgName:placeholder completed:^(UIImage * _Nonnull image, NSString * _Nonnull imageURL) {
            dispatch_async(dispatch_get_main_queue(), ^{ //在主线程刷新UI
                self.image = image;
                completedBlock(image,imageURL);
            });
        }];
    });
    
   
}

@end
