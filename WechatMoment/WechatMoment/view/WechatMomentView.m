//
//  WechatMomentView.m
//  WechatMoment
//
//  Created by panh on 2018/11/10.
//  Copyright © 2018 ph. All rights reserved.
//

#import "WechatMomentView.h"
#import "ProfileTableViewCell.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import <MJRefresh.h>
#import "RequestUtil.h"
#import "TableViewCellFacotry.h"

#import "ImgTableViewCell.h"
#import "TextTableViewCell.h"
#import "TextImgTableViewCell.h"
#import "ImgCommTableCiewCell.h"
#import "TextCommTableViewCell.h"
#import "AllTableViewCell.h"
#import "WeChatMgr.h"

#define CELL_PROFILE @"ProfileTableViewCell"
#define CELL_CONTENT @"TwContentTableViewCell"



@interface WechatMomentView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) WeChatMgr *weChatMgr;

@property (nonatomic,strong) UITableView *tableView;//朋友圈列表
@property (nonatomic,strong) UIBarButtonItem *btnBack;//返回按钮
@property (nonatomic,strong) UIBarButtonItem *btnCamera;//照相按钮
@property (nonatomic,assign) CGFloat oldAlpha;


@end


@implementation WechatMomentView


-(WeChatMgr *)weChatMgr{
    if(_weChatMgr == nil){
        _weChatMgr = [WeChatMgr sharedManager];
    }
    return _weChatMgr;
}


-(void)viewDidLoad{
    [super viewDidLoad];
    [self setNavTitle:@"朋友圈"];
    [self initView];
    
    [self.weChatMgr downLoadUserInfoCallback:^(id  _Nonnull result) {
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
       
    }];
  
    [self.weChatMgr downloadTweetsListCallback:^(id  _Nonnull result) {
      [self addRefreshHeaderFooter];
      [self.tableView reloadData];
    }];
   
}


-(void)addNavBarBtn{
    
    _btnCamera=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"camera"]  style:UIBarButtonItemStylePlain target:self action:@selector(onClickCamera)];
    _btnCamera.tintColor = [UIColor blackColor];
    self.curViewController.navigationItem.rightBarButtonItem = _btnCamera;
    
    
    _btnBack=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_return"]  style:UIBarButtonItemStylePlain target:self action:@selector(onClickBack)];
    _btnBack.tintColor = [UIColor blackColor];
    self.curViewController.navigationItem.leftBarButtonItem = _btnBack;
    
}


-(void)onClickCamera{
    
}

-(void)onClickBack{
    
}








-(void)initView{
    self.curViewController.automaticallyAdjustsScrollViewInsets = NO;
   
    _tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self addSubview:_tableView];

    [_tableView registerClass:[ProfileTableViewCell class] forCellReuseIdentifier:CELL_PROFILE];
    [_tableView registerClass:[ImgTableViewCell class] forCellReuseIdentifier:@"ImgTableViewCell"];
    [_tableView registerClass:[TextTableViewCell class] forCellReuseIdentifier:@"TextTableViewCell"];
    [_tableView registerClass:[TextImgTableViewCell class] forCellReuseIdentifier:@"TextImgTableViewCell"];
    [_tableView registerClass:[ImgCommTableCiewCell class] forCellReuseIdentifier:@"ImgCommTableCiewCell"];
    [_tableView registerClass:[TextCommTableViewCell class] forCellReuseIdentifier:@"TextCommTableViewCell"];
    [_tableView registerClass:[AllTableViewCell class] forCellReuseIdentifier:@"AllTableViewCell"];
    
   
    //mjrefresh 位置
    if (@available(iOS 11.0, *)) {
#ifdef __IPHONE_11_0
        if ([_tableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
#endif
    }
   
}

-(void)addRefreshHeaderFooter{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        __weak __typeof(&*self)weakSelf = self;
        [weakSelf.tableView.mj_header beginRefreshing];
       
        dispatch_async(dispatch_get_global_queue(0, 0), ^{ // 处理耗时操作在此次添加
            weakSelf.weChatMgr.pageIndex = 0;
            [weakSelf.weChatMgr getTwList];
            dispatch_async(dispatch_get_main_queue(), ^{ //在主线程刷新UI
                [weakSelf.tableView reloadData];
                [weakSelf.tableView.mj_footer setState:MJRefreshStateIdle];
                [weakSelf.tableView.mj_header endRefreshing];
            });
        });
     
    }];
    header.stateLabel.font = [UIFont systemFontOfSize:12];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:11];
    header.stateLabel.textColor = [UIColor lightGrayColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor lightGrayColor];
    _tableView.mj_header = header;
    
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        __weak __typeof(&*self)weakSelf = self;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{ // 处理耗时操作在此次添加
            weakSelf.weChatMgr.pageIndex = weakSelf.weChatMgr.pageIndex+1;
            [weakSelf.weChatMgr getTwList];
            dispatch_async(dispatch_get_main_queue(), ^{ //在主线程刷新UI
                [weakSelf.tableView reloadData];
                if(weakSelf.weChatMgr.twList.count<weakSelf.weChatMgr.allTwList.count){
                   [weakSelf.tableView.mj_footer endRefreshing];
                }else{
                   [weakSelf.tableView.mj_footer  endRefreshingWithNoMoreData];
                }
            });
        });
    }];
    
    footer.stateLabel.font = [UIFont systemFontOfSize:12];// 设置字体
    footer.stateLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
    footer.stateLabel.textColor = [UIColor lightGrayColor]; // 设置颜色
    footer.automaticallyRefresh = NO; // 禁止自动加载
    
    self.tableView.mj_footer = footer;
}



#pragma mark tablecell delegate datasource

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1 + self.weChatMgr.twList.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    
    if(row==0){//个人资料
        return HEIGHT_BG_PROFILE;
    }else {
        TwContent *content = [self.weChatMgr.twList objectAtIndex:row-1];
        return [tableView fd_heightForCellWithIdentifier:[self.weChatMgr getCellIDStrByCellType:content.cellType] cacheByIndexPath:indexPath configuration:^(id cell) {
            BaseContentTableViewCell *newCell = cell;
            newCell.twContent = content;
        }];
    }
    
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    if(row == 0){
        ProfileTableViewCell *cell = (ProfileTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CELL_PROFILE];
        if(cell==nil){
            cell = [[ProfileTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_PROFILE];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.user = self.weChatMgr.user;
        return cell;
    }else{
        TwContent *content = [self.weChatMgr.twList objectAtIndex:(row-1)];
        BaseContentTableViewCell *cell = [[TableViewCellFacotry sharedManager] createCellByType:content.cellType TableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.twContent = content;
        return cell;
    }
   
}






-(void)hideNav{
    [self.curViewController.navigationController.navigationBar setTranslucent:YES];
    UIImage *image = [self imageWithColor:[UIColor colorWithRed:242 green:242 blue:242 alpha:0]];
    [self.curViewController.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    _btnBack.tintColor = [UIColor whiteColor];
    _btnCamera.tintColor = [UIColor whiteColor];
    self.curViewController.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor]};
    [self.curViewController.navigationController.navigationBar setShadowImage:[UIImage new]];
 
}

-(void)viewWillAppear{
    //隐藏导航栏
    [self hideNav];
    
   // [self.curViewController.navigationController setNavigationBarHidden:YES animated:NO];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat reOffset = scrollView.contentOffset.y + HEIGHT_BG_PROFILE ;
    CGFloat alpha = reOffset / HEIGHT_BG_PROFILE;

    if (alpha <= 1)//下拉永不显示导航栏
    {
        alpha = 0;
    }
    else//上划前一个导航栏的长度是渐变的
    {
        alpha -= 1;

    }
  

        UIColor *color = [UIColor colorWithRed:0 green:0 blue:0 alpha:alpha];
        _btnBack.tintColor = color;
        _btnCamera.tintColor = color;
    self.curViewController.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:color};


    UIImage *image = [self imageWithColor:[UIColor colorWithRed:242 green:242 blue:242 alpha:alpha]];
    [self.curViewController.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
   
        [self.curViewController.navigationController.navigationBar setShadowImage:[UIImage new]];
    
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    if(_oldAlpha>=alpha){//下拉 减小
        if(alpha<=0){
            [self hideNav];
        }
    }
    _oldAlpha = alpha;
}

/// 使用颜色填充图片
- (UIImage *)imageWithColor:(UIColor *)color{
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    return theImage;
}



@end
