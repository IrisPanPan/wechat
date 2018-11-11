//
//  TextTableViewCell.m
//  WechatMoment
//
//  Created by panh on 2018/11/11.
//  Copyright © 2018 ph. All rights reserved.
//

#import "TextTableViewCell.h"
@interface TextTableViewCell()
@property (nonatomic,strong) UILabel *lbContent;//内容
@end

@implementation TextTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initNewView];
    }
    return self;
}

-(void)initNewView{
    _lbContent = [UILabel new];
    _lbContent.numberOfLines = 0;
    _lbContent.lineBreakMode = NSLineBreakByWordWrapping;
    _lbContent.textAlignment = NSTextAlignmentLeft;
    _lbContent.textColor = [Util parseStringToColor:@"#333333"];
    _lbContent.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_lbContent];
    
    [_lbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lbName.mas_bottom).offset(5);
        make.left.mas_equalTo(self.lbName.mas_left);
        make.right.mas_equalTo(-20);
       // make.bottom.mas_equalTo(-20);
    }];
    
    [self.imgBtnReply mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lbContent.mas_bottom).offset(5);
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(-20);
        make.width.height.mas_equalTo(20);
    }];
}


-(void)setTwContent:(TwContent *)twContent{
    [super setTwContent:twContent];
    self.lbContent.text = twContent.content;

    
}

@end
