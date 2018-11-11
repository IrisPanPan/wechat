//
//  TwContent.h
//  WechatMoment
//  朋友圈推送内容实体类
//  Created by panh on 2018/11/8.
//  Copyright © 2018 ph. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "User.h"
NS_ASSUME_NONNULL_BEGIN

@interface TwContent : NSObject

@property(nonatomic,assign) ContentCellType cellType;

@property(nonatomic,copy) NSString *content;//发送的朋友圈内容
@property(nonatomic,strong) NSMutableArray *imgList;//发送的朋友圈内容
@property(nonatomic,strong) User *sender;//发送者对象

@property(nonatomic,strong) NSMutableArray *commentList;//评论列表（里面是TwContent类对象）

+(TwContent *)create;
-(TwContent *)content:(NSString *)content;
-(TwContent *)sender:(User *)sender;
-(TwContent *)commentList:(NSMutableArray *)commentList;

@end

NS_ASSUME_NONNULL_END
