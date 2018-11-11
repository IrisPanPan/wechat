//
//  WeChatMgr.h
//  WechatMoment
//
//  Created by panh on 2018/11/11.
//  Copyright © 2018 ph. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TwContent.h"
NS_ASSUME_NONNULL_BEGIN

@interface WeChatMgr : NSObject
//获取信息的cell类型
+(ContentCellType)getCellTypeByTwContent:(TwContent *)twContent;
//获取重用的cell id
+(NSString *)getCellIDStrByCellType:(ContentCellType)cellType;
@end

NS_ASSUME_NONNULL_END
