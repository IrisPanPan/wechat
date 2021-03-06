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

#define LIST_PAGE_SIZE 5 //翻页查询 一页5条

@interface WeChatMgr : NSObject

@property (nonatomic,strong) NSArray *twList;
@property (nonatomic,strong) NSMutableArray *allTwList;//所有列表
@property (nonatomic,strong) User *user;//当前用户
@property (nonatomic,assign) NSInteger pageIndex;//当前页数

+ (id)sharedManager;

//获取信息的cell类型
-(ContentCellType)getCellTypeByTwContent:(TwContent *)twContent;

//获取重用的cell id
-(NSString *)getCellIDStrByCellType:(ContentCellType)cellType;

/**
 下载个人信息
 */
-(void)downLoadUserInfoCallback:(void (^)(id result))callback;

/**
 下载微信朋友圈列表
 */
-(void)downloadTweetsListCallback:(void (^)(id result))callback;

/**
 查询翻页
 */
-(void)getTwList;
@end

NS_ASSUME_NONNULL_END
