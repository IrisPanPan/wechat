//
//  BaseUIView.m
//  WechatMoment
//
//  Created by panh on 2018/11/10.
//  Copyright © 2018 ph. All rights reserved.
//

#import "BaseUIView.h"

@implementation BaseUIView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _width = SCREEN_WIDTH;
        _height = APPVIEW_HEIGHT;
    }
    return self;
}


-(UIViewController *)curViewController{
    if(_curViewController==nil){
        _curViewController = [Util getViewControllerByView:[self superview]];
    }
    return _curViewController;
}



- (void)viewDidLoad {
    [self addNavBarBtn];
}

- (void)viewWillAppear{
   
}

- (void)viewDidAppear{

}

- (void)viewWillDisappear{

}

- (void)viewDidDisappear{
   
}

-(void)didReceiveMemoryWarning{
    
}


#pragma mark Navbar Setting 导航栏设置

//添加导航栏按钮
-(void)addNavBarBtn{
  
}


//设置导航栏标题
-(void)setNavTitle:(NSString *)navTitle{
    self.curViewController.navigationItem.title = navTitle;
}


@end
