//
//  ProfileTableViewCell.h
//  WechatMoment
//  个人资料 cell
//  Created by panh on 2018/11/10.
//  Copyright © 2018 ph. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileTableViewCell : UITableViewCell
@property (nonatomic,strong) User *user;
@end

NS_ASSUME_NONNULL_END
