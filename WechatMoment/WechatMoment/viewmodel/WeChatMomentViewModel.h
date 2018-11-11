//
//  WeChatMomentViewModel.h
//  WechatMoment
//  朋友圈界面视图模型
//  Created by panh on 2018/11/10.
//  Copyright © 2018 ph. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
NS_ASSUME_NONNULL_BEGIN

@interface WeChatMomentViewModel : NSObject

@property (nonatomic,strong,readonly) NSMutableArray *twList;//微信列表
@property (nonatomic,strong,readonly) User *user;//当前用户

/**
 下拉刷新，获取新的列表
 */
-(void)loadNewDataList;

/**
 上拉,加载更多的历史数据
 */
-(void)loadMoreOldData;


/**
 下载个人信息
 */
-(void)downLoadUserInfo;


/**
 下载信息列表
 */
-(void)downLoadTwList;




@end

NS_ASSUME_NONNULL_END
