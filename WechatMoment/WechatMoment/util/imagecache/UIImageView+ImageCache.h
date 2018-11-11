//
//  UIImageView+ImageCache.h
//  WechatMoment
//
//  Created by panh on 2018/11/9.
//  Copyright © 2018 ph. All rights reserved.
//

#import "ImageCache.h"
#import "ImageMgr.h"
NS_ASSUME_NONNULL_BEGIN


@interface UIImageView (ImageCache)

-(void)setImageWithURL:(NSString *)url placeholderImage:(NSString *)placeholder competed:(ImageCompletionBlock)completedBlock;
@end

NS_ASSUME_NONNULL_END
