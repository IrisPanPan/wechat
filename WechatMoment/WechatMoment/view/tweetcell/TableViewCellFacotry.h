//
//  TableViewCellFacotry.h
//  WechatMoment
//  创建不通种类的微信cell
//  Created by panh on 2018/11/11.
//  Copyright © 2018 ph. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseContentTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN


@interface TableViewCellFacotry : NSObject
+ (id)sharedManager;

-(id)createCellByType:(ContentCellType)type TableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
