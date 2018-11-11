//
//  ImgCommTableCiewCell.m
//  WechatMoment
//
//  Created by panh on 2018/11/11.
//  Copyright © 2018 ph. All rights reserved.
//

#import "ImgCommTableCiewCell.h"
#import "ImageCollectionView.h"
#import "CommentsView.h"
@interface ImgCommTableCiewCell()
@property (nonatomic,strong) ImageCollectionView *imageCV;//九宫格图片
@property (nonatomic,strong) CommentsView *commView;//评论
@end
@implementation ImgCommTableCiewCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initNewView];
    }
    return self;
}

-(void)initNewView{
    
    _imageCV = [ImageCollectionView new];
    [self.contentView addSubview:_imageCV];
    [_imageCV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lbName.mas_bottom).offset(5);
        make.left.mas_equalTo(self.lbName.mas_left);
        make.right.mas_equalTo(-50);
        make.height.mas_equalTo(0);
    }];
    
    _commView = [CommentsView new];
    [self.contentView addSubview:_commView];
    [_commView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageCV.mas_bottom).offset(5);
        make.left.mas_equalTo(self.imageCV.mas_left);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(0);
    }];
    
    [self.imgBtnReply mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.commView.mas_bottom).offset(5);
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(-20);
        make.width.height.mas_equalTo(20);
    }];
    
}


-(void)setTwContent:(TwContent *)twContent{
    [super setTwContent:twContent];
    self.imageCV.imgList = twContent.imgList;
    self.commView.commList = twContent.commentList;
}


@end
