//
//  ImageCollectionViewCell.m
//  WechatMoment
//
//  Created by panh on 2018/11/10.
//  Copyright © 2018 ph. All rights reserved.
//

#import "ImageCollectionViewCell.h"
#import "ImageMgr.h"
#import <Masonry.h>
#import "UIImageView+ImageCache.h"
@interface ImageCollectionViewCell()
@property(nonatomic,assign) CGFloat height;
@property(nonatomic,assign) CGFloat width;
@property(nonatomic,strong) UIImageView *imgView;
@end
@implementation ImageCollectionViewCell


-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self initView];
    }
    return self;
}




-(void)initView{
    
   
    _imgView = [UIImageView new];
    _imgView.image = [UIImage imageNamed:@"placeholder_img"];
    _imgView.contentMode = UIViewContentModeScaleAspectFit;
    //_imgView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_imgView];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.bottom.mas_equalTo(0);
    }];

    
}

-(void)setImgUrl:(NSString *)imgUrl{
    if((imgUrl!=nil) && (!imgUrl.isEmptyStr)){
        [self.imgView setImageWithURL:imgUrl placeholderImage:@"placeholder_img" competed:^(UIImage * _Nonnull image, NSString * _Nonnull imageURL) {
            
        }];
//        [[ImageMgr sharedManager] downloadImageWithURL:imgUrl PlaceHolderImgName:@"placeholder_img" completed:^(UIImage * _Nonnull image) {
//            self.imgView.image = image;
//        }];
    }
}

@end
