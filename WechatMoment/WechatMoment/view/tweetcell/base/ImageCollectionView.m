//
//  ImageCollectionView.m
//  WechatMoment
//
//  Created by panh on 2018/11/11.
//  Copyright © 2018 ph. All rights reserved.
//

#import "ImageCollectionView.h"
#import <Masonry.h>
#import "ImageCollectionViewCell.h"
@interface ImageCollectionView()
@property (nonatomic,assign)BOOL isFour;//是否是4宫格
@end

@implementation ImageCollectionView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self initView];
    }
    return self;
}



-(void)setImgList:(NSMutableArray *)imgList{
    //回复原值 避免重复混乱
    //[_imgCollectionView reloadData];
    _isFour = NO;
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(VC_IMG_CELL_W*3+VC_IMG_CELL_HS*2);
    }];
    _imgList = imgList;
    
    if(_imgList.count == 4){
        _isFour = YES;
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
             make.width.mas_equalTo(VC_IMG_CELL_W*2+VC_IMG_CELL_HS);
        }];
    }
    CGFloat height = 0;
    if(self.imgList==nil || self.imgList.count ==0){
        height = 0;
    }else if(self.imgList.count<=3){
        height = VC_IMG_CELL_W;
    }else if((self.imgList.count>3) && (self.imgList.count<7) ){
        height = VC_IMG_CELL_W*2+VC_IMG_CELL_VS;
    }else{
        height = VC_IMG_CELL_W*3+VC_IMG_CELL_VS*2;
    }
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    
    [_imgCollectionView reloadData];
}


-(void)initView{
    _imgCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, APPVIEW_HEIGHT) collectionViewLayout:[UICollectionViewFlowLayout new]];
    _imgCollectionView.backgroundColor = [UIColor clearColor];
    [_imgCollectionView registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:@"ImageCollectionViewCell"];
    _imgCollectionView.showsVerticalScrollIndicator = NO;
    _imgCollectionView.delegate = self;
    _imgCollectionView.dataSource = self;
    [self addSubview:_imgCollectionView];
    
    [_imgCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
      //  make.height.mas_equalTo(0);
    }];
   

}


#pragma mark collectionview delegeate
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imgList.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"ImageCollectionViewCell";
    NSUInteger row = [indexPath row];
    ImageCollectionViewCell *cell = (ImageCollectionViewCell *)[_imgCollectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
 
    cell.imgUrl = [self.imgList objectAtIndex:row];
  
    return cell;
}

//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return VC_IMG_CELL_VS;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return VC_IMG_CELL_HS;
}


//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
   
    if(self.imgList.count==0){
        return CGSizeMake(0, 0);
    }else {
        return CGSizeMake(VC_IMG_CELL_W, VC_IMG_CELL_W);
    }
}


//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //    [_txtRemark resignFirstResponder];
    //    RedlineImg *rImg = [_redlineImgList objectAtIndexCheck:indexPath.row];
    //    [self showBigImage:rImg.img];
    
}
@end
