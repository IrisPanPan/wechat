//
//  Util.h
//  WechatMoment
//
//  Created by panh on 2018/11/10.
//  Copyright © 2018 ph. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Util : NSObject

extern BOOL isNetConnect;// 网络是否连接



/**
 获取当前view的viewController
 */
+(UIViewController *)getViewControllerByView:(UIView *)superView;


/*
 *  获取颜色
 */
+(UIColor *) parseStringToColor: (NSString *) stringToConvert;

+(UIImage *) CompressImage:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

+(NSString *)getTypeForImageData:(NSData *)data ;


// md5 加密
+ (NSString *)getMD5Str:(NSString *)str;
@end

NS_ASSUME_NONNULL_END
