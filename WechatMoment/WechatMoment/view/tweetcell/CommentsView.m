//
//  CommentsView.m
//  WechatMoment
//  评论列表
//  Created by panh on 2018/11/11.
//  Copyright © 2018 ph. All rights reserved.
//

#import "CommentsView.h"
#import <Masonry.h>
#import "CommentsTableViewCell.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import "User.h"

@interface CommentsView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UILabel *lbCommUsers;
@property(nonatomic,strong)UIView *line;
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation CommentsView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        [self initView];
    }
    return self;
}

-(void)initView{
    
    _lbCommUsers = [UILabel new];
    _lbCommUsers.textAlignment = NSTextAlignmentLeft;
    _lbCommUsers.textColor = [Util parseStringToColor:@"#536993"];
    _lbCommUsers.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    _lbCommUsers.numberOfLines = 0;
    [self addSubview:_lbCommUsers];
    
    _line = [UIView new];
    _line.backgroundColor = [Util parseStringToColor:@"#d5d5d5"];
    [self addSubview:_line];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, APPVIEW_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    [_tableView registerClass:[CommentsTableViewCell class] forCellReuseIdentifier:@"CommentsTableViewCell"];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    [self addSubview:_tableView];
    

    [_lbCommUsers mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lbCommUsers.mas_bottom).offset(3);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.line.mas_bottom);
        make.left.right.bottom.mas_equalTo(0);
    }];

}





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
    return self.commList.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    NSInteger row = indexPath.row;
    CGFloat height = [tableView fd_heightForCellWithIdentifier:@"CommentsTableViewCell" cacheByIndexPath:indexPath configuration:^(id cell) {
        CommentsTableViewCell *newCell = cell;
        TwContent *content = [self.commList objectAtIndex:row];
        newCell.twContent = content;
    }];
    return height;
   
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    CommentsTableViewCell *cell = (CommentsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CommentsTableViewCell"];
    if(cell==nil){
        cell = [[CommentsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommentsTableViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.twContent = [self.commList objectAtIndex:row];
    return cell;
   
}


-(void)setCommList:(NSMutableArray *)commList{
    //回复原值
    _commList = commList;
    NSString *users = @"";
    CGFloat tmpHeight = 0;
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0);
    }];
    
    UIFont *font = [UIFont systemFontOfSize:15];
    for(int i=0;i<_commList.count;i++){
        TwContent *twc = [_commList objectAtIndex:i];
        if(i==0){
            users = twc.sender.nick;
        }else{
            users = [NSString stringWithFormat:@"%@，%@",users,twc.sender.nick];
        }
        
        NSString *tmpstr = twc.content;
        CGRect suggestedRect = [tmpstr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-120, MAXFLOAT)
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{ NSFontAttributeName : font }
                                                  context:nil];
        tmpHeight = tmpHeight + suggestedRect.size.height + 4;
        
    }
    _lbCommUsers.text = users;
    if(_commList.count>0){
        _lbCommUsers.text = users;
    }
    [_lbCommUsers sizeToFit];
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(tmpHeight+self.lbCommUsers.frame.size.height+14);
    }];
    [_tableView reloadData];
    
}
@end
