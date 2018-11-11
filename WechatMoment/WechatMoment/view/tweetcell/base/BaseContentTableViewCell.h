//
//  BaseContentTableViewCell.h
//  WechatMoment
//
//  Created by panh on 2018/11/11.
//  Copyright © 2018 ph. All rights reserved.
//


#import <Masonry.h>
#import "ImageMgr.h"
#import "TwContent.h"
NS_ASSUME_NONNULL_BEGIN

@interface BaseContentTableViewCell : UITableViewCell

@property (nonatomic,strong) TwContent *twContent;
@property (nonatomic,strong) UIImageView *imgAvatar;//头像
@property (nonatomic,strong) UILabel *lbName;//名称
@property (nonatomic,strong) UIImageView *imgBtnReply;//回复按钮


@end

NS_ASSUME_NONNULL_END
