//
//  BaseUIViewController.m
//  WechatMoment
//
//  Created by panh on 2018/11/10.
//  Copyright © 2018 ph. All rights reserved.
//

#import "BaseUIViewController.h"

@interface BaseUIViewController ()

@end

@implementation BaseUIViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if(_baseView){
        [self.view addSubview:_baseView];
        _baseView.frame = CGRectMake(0, 0, _baseView.width, _baseView.height);
        [_baseView viewDidLoad];
    }
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(_baseView){
        [_baseView viewWillAppear];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if(_baseView){
        [_baseView viewDidAppear];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if(_baseView){
        [_baseView viewWillDisappear];
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if(_baseView){
        [_baseView viewDidDisappear];
    }
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    if(_baseView){
        [_baseView didReceiveMemoryWarning];
    }
}

@end
