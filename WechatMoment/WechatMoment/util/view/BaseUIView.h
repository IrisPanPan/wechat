//
//  BaseUIView.h
//  WechatMoment
//  界面基础类
//  Created by panh on 2018/11/10.
//  Copyright © 2018 ph. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseUIView : UIView

@property(nonatomic,assign) CGFloat width;
@property(nonatomic,assign) CGFloat height;

@property(nonatomic,strong) UIViewController *curViewController;//当前界面的viewcontroller



- (void)viewDidLoad;
- (void)viewWillAppear;
- (void)viewDidAppear;
- (void)viewWillDisappear;
- (void)viewDidDisappear;
- (void)didReceiveMemoryWarning;

//添加导航栏按钮
-(void)addNavBarBtn;
//设置导航栏标题
-(void)setNavTitle:(NSString *)navTitle;

@end

NS_ASSUME_NONNULL_END
