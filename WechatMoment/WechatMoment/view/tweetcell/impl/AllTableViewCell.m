
//
//  AllTableViewCell.m
//  WechatMoment
//
//  Created by panh on 2018/11/11.
//  Copyright © 2018 ph. All rights reserved.
//

#import "AllTableViewCell.h"

@interface AllTableViewCell()
@property (nonatomic,strong) UILabel *lbContent;//内容
@property (nonatomic,strong) ImageCollectionView *imageCV;//九宫格图片
@property (nonatomic,strong) CommentsView *commView;//评论
@end
@implementation AllTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initNewView];
    }
    return self;
}

-(UILabel *)lbContent{
    if(_lbContent ==nil){
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
            make.width.mas_equalTo(SCREEN_WIDTH-150);
            make.height.mas_equalTo(0);
        }];
    }
    return _lbContent;
}

-(ImageCollectionView *)imageCV{
    if(_imageCV==nil){
        _imageCV = [ImageCollectionView new];
        [self.contentView addSubview:_imageCV];
        [_imageCV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.lbContent.mas_bottom).offset(5);
            make.left.mas_equalTo(self.lbContent.mas_left);
            make.width.mas_equalTo(VC_IMG_CELL_W*3+VC_IMG_CELL_HS*2);
            make.height.mas_equalTo(0);
        }];
    }
    return _imageCV;
}

-(CommentsView *)commView{
    if(_commView==nil){
        _commView = [CommentsView new];
        [self.contentView addSubview:_commView];
        [_commView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.imageCV.mas_bottom).offset(5);
            make.left.mas_equalTo(self.imageCV.mas_left);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(0);
            make.bottom.mas_equalTo(-45);
        }];
    }
    return _commView;
}

-(void)initNewView{
     [self lbContent];
     [self imageCV];
     [self commView];
    
//    _lbContent = [UILabel new];
//    _lbContent.numberOfLines = 0;
//    _lbContent.lineBreakMode = NSLineBreakByWordWrapping;
//    _lbContent.textAlignment = NSTextAlignmentLeft;
//    _lbContent.textColor = [Util parseStringToColor:@"#333333"];
//    _lbContent.font = [UIFont systemFontOfSize:16];
//    [self.contentView addSubview:_lbContent];
//
//    [_lbContent mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.lbName.mas_bottom).offset(5);
//        make.left.mas_equalTo(self.lbName.mas_left);
//        make.width.mas_equalTo(SCREEN_WIDTH-150);
//        make.height.mas_equalTo(0);
//    }];
//
//    _imageCV = [ImageCollectionView new];
//    [self.contentView addSubview:_imageCV];
//    [_imageCV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.lbContent.mas_bottom).offset(5);
//        make.left.mas_equalTo(self.lbContent.mas_left);
//        make.width.mas_equalTo(VC_IMG_CELL_W*3+VC_IMG_CELL_HS*2);
//        make.height.mas_equalTo(0);
//    }];
//
//    _commView = [CommentsView new];
//    [self.contentView addSubview:_commView];
//    [_commView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.imageCV.mas_bottom).offset(5);
//        make.left.mas_equalTo(self.imageCV.mas_left);
//        make.right.mas_equalTo(-20);
//        make.height.mas_equalTo(0);
//        make.bottom.mas_equalTo(-45);
//    }];
//
    [self.imgBtnReply mas_makeConstraints:^(MASConstraintMaker *make) {
       // make.top.mas_equalTo(self.commView.mas_bottom).offset(5);
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(-20);
        make.width.height.mas_equalTo(20);
    }];
}


-(void)setTwContent:(TwContent *)twContent{
    [super setTwContent:twContent];
    [self.lbContent mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0);
    }];
    self.lbContent.text = twContent.content;
    NSString *tmpstr = twContent.content;
    UIFont *font = [UIFont systemFontOfSize:15];
    CGRect suggestedRect = [tmpstr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-140, MAXFLOAT)
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{ NSFontAttributeName : font }
                                                context:nil];
    CGFloat tmpHeight = suggestedRect.size.height + 4;
    
    [self.lbContent mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(tmpHeight);
    }];
    
    [_imageCV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0);
    }];
    
    [_commView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0);
    }];
    
    self.imageCV.imgList = twContent.imgList;
    self.commView.commList = twContent.commentList;
    
}
@end
