//
//  BaseUIViewController.h
//  WechatMoment
//
//  Created by panh on 2018/11/10.
//  Copyright © 2018 ph. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseUIView.h"
NS_ASSUME_NONNULL_BEGIN

@interface BaseUIViewController : UIViewController
@property(nonatomic,strong)BaseUIView *baseView;
@end

NS_ASSUME_NONNULL_END
