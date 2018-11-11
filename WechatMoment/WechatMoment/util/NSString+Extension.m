//
//  NSString+Extention.m
//  WechatMoment
//
//  Created by panh on 2018/11/9.
//  Copyright © 2018 ph. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)


/**
 判断是否是空字符串  回车＋空格
 
 @return 否是空字符串
 */
-(BOOL)isEmptyStr{
    if((nil!=self)&&(![self isEqual:[NSNull null]])){
        // 去除两端空格
        NSString *temp = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        // 去除两端空格和回车
        NSString *text = [temp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        return [@"" isEqualToString:text];
    }
    return YES;
}
@end
