//
//  ProfileTableViewCell.m
//  WechatMoment
//
//  Created by panh on 2018/11/10.
//  Copyright © 2018 ph. All rights reserved.
//

#import "ProfileTableViewCell.h"
#import "ImageMgr.h"
#import "UIImageView+ImageCache.h"
@interface ProfileTableViewCell()
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,strong) UIImageView *imgProfileBg;//个人资料背景图
@property (nonatomic,strong) UILabel *lbProfileName;//个人资料名称
@property (nonatomic,strong) UIImageView *imgProfileAvatar;//个人资料头像

@end

@implementation ProfileTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _width = SCREEN_WIDTH;
        [self initView];
    }
    return self;
}


-(void)initView{
    
    _imgProfileBg = [UIImageView new];
    _imgProfileBg.image = [UIImage imageNamed:@"placeholder_pbg"];
    _imgProfileBg.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_imgProfileBg];
   

    _lbProfileName = [UILabel new];
    _lbProfileName.numberOfLines = 1;
    _lbProfileName.textAlignment = NSTextAlignmentRight;
    _lbProfileName.textColor = [UIColor whiteColor];
    _lbProfileName.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    _lbProfileName.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_lbProfileName];

    
    
    _imgProfileAvatar = [UIImageView new];
    _imgProfileAvatar.layer.borderWidth = 2;
    _imgProfileAvatar.layer.borderColor = [UIColor whiteColor].CGColor;
    _imgProfileAvatar.image = [UIImage imageNamed:@"placeholder_user"];
    _imgProfileAvatar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_imgProfileAvatar];
    
    NSDictionary *metres = @{@"height":@270};
    NSDictionary *views = @{@"imgProfileBg":_imgProfileBg};
    
    NSString *hVFL = @"H:|-0-[imgProfileBg]-0-|";
    NSArray *hCons = [NSLayoutConstraint constraintsWithVisualFormat:hVFL options:0 metrics:nil views:views];
    [self.contentView addConstraints:hCons];
    
    NSString *vVFL = @"V:|-0-[imgProfileBg(height)]-0-|";
    NSArray *vCons = [NSLayoutConstraint constraintsWithVisualFormat:vVFL options:NSLayoutFormatAlignAllRight metrics:metres views:views];
    [self.contentView addConstraints:vCons];
    
    
    
    metres = @{@"imgwidth":@60,@"lbwidth":@200,@"lbheight":@20};
    views = @{@"imgProfileAvatar":_imgProfileAvatar,@"lbProfileName":_lbProfileName};
    
    hVFL = @"H:[lbProfileName(lbwidth)]-20-[imgProfileAvatar(imgwidth)]-15-|";
    hCons = [NSLayoutConstraint constraintsWithVisualFormat:hVFL options:NSLayoutFormatAlignAllCenterY metrics:metres views:views];
    [self.contentView addConstraints:hCons];
    
    vVFL = @"V:[imgProfileAvatar(imgwidth)]-15-|";
    vCons = [NSLayoutConstraint constraintsWithVisualFormat:vVFL options:NSLayoutFormatAlignAllRight metrics:metres views:views];
    [self.contentView addConstraints:vCons];
 
    
    
}


-(void)setUser:(User *)user{
    if(user){
        _user = user;
        if(_user.profileImage!=nil){
            [self.imgProfileBg setImageWithURL:_user.profileImage placeholderImage:@"placeholder_pbg" competed:^(UIImage * _Nonnull image, NSString * _Nonnull imageURL) {
                
            }];
           
        }
        if(_user.avatar!=nil){
            [self.imgProfileAvatar setImageWithURL:_user.avatar placeholderImage:@"placeholder_user" competed:^(UIImage * _Nonnull image, NSString * _Nonnull imageURL) {
                
            }];
           
        }
        if(_user.nick!=nil){
            self.lbProfileName.text = _user.nick;
        }
    }
}

@end
