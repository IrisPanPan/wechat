//
//  CommentsTableViewCell.m
//  WechatMoment
//
//  Created by panh on 2018/11/11.
//  Copyright © 2018 ph. All rights reserved.
//

#import "CommentsTableViewCell.h"
#import <Masonry.h>
#import "User.h"
@interface CommentsTableViewCell()
//@property(nonatomic,strong)UILabel *lbName;
@property(nonatomic,strong)UILabel *lbComm;
@end

@implementation CommentsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self initView];
    }
    return self;
}
-(void)initView{
   
    
    _lbComm = [UILabel new];
    _lbComm.textAlignment = NSTextAlignmentLeft;
   // _lbComm.textColor = [Util parseStringToColor:@"#333333"];
    _lbComm.font = [UIFont systemFontOfSize:15];
    _lbComm.numberOfLines = 0;
    [self.contentView addSubview:_lbComm];
    
    [_lbComm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(2);
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
        make.bottom.mas_equalTo(-2);
    }];
  
}

-(void)setTwContent:(TwContent *)twContent{
    _twContent = twContent;
    NSString *comm = [NSString stringWithFormat:@"%@：%@",twContent.sender.nick,twContent.content];
    NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc] initWithString:comm];
    [aStr addAttribute:NSForegroundColorAttributeName value:[Util parseStringToColor:@"#536993"] range:NSMakeRange(0, twContent.sender.nick.length)];
    [aStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:15] range:NSMakeRange(0, twContent.sender.nick.length)];
    [aStr addAttribute:NSForegroundColorAttributeName value:[Util parseStringToColor:@"#333333"] range:NSMakeRange(twContent.sender.nick.length,twContent.content.length+1)];
    _lbComm.attributedText = aStr;
   
}
@end
