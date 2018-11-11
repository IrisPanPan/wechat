//
//  BaseContentTableViewCell.m
//  WechatMoment
//  基础cell  含有名称 头像等基础组件
//  Created by panh on 2018/11/11.
//  Copyright © 2018 ph. All rights reserved.
//

#import "BaseContentTableViewCell.h"
#import "UIImageView+ImageCache.h"
@interface BaseContentTableViewCell()

@end


@implementation BaseContentTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}


-(void)initView{
    _imgAvatar = [UIImageView new];
    _imgAvatar.image = [UIImage imageNamed:@"placeholder_user"];
    [self.contentView addSubview:_imgAvatar];
    
    _lbName = [UILabel new];
    _lbName.numberOfLines = 1;
    _lbName.textAlignment = NSTextAlignmentLeft;
    _lbName.textColor = [Util parseStringToColor:@"#536993"];
    _lbName.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    [self.contentView addSubview:_lbName];
    
    [_imgAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(45);
        make.top.left.mas_equalTo(20);
    }];
    
    [_lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imgAvatar.mas_top);
        make.left.mas_equalTo(self.imgAvatar.mas_right).offset(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(20);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
        make.bottom.mas_equalTo(-0.5);
    }];
    
    
    _imgBtnReply = [UIImageView new];
    _imgBtnReply.image = [UIImage imageNamed:@"icon_reply"];
    [self.contentView addSubview:_imgBtnReply];
    
}



-(void)setTwContent:(TwContent *)twContent{
    
    _twContent = twContent;
    
    //头像
    if(twContent.sender.avatar!=nil){
        [self.imgAvatar setImageWithURL:twContent.sender.avatar placeholderImage:@"placeholder_user" competed:^(UIImage * _Nonnull image, NSString * _Nonnull imageURL) {
            
        }];
//        [[ImageMgr sharedManager] downloadImageWithURL:twContent.sender.avatar PlaceHolderImgName:@"placeholder_user" completed:^(UIImage * _Nonnull image) {
//            self.imgAvatar.image = image;
//        }];
    }
    
    _lbName.text = twContent.sender.nick;
    
}
@end
