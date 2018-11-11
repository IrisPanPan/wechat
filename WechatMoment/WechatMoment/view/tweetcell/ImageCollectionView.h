//
//  ImageCollectionView.h
//  WechatMoment
//  九宫格图片
//  Created by panh on 2018/11/11.
//  Copyright © 2018 ph. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define VC_IMG_CELL_W 70//九宫格宽高
#define VC_IMG_CELL_HS 5//九宫格横向空隙
#define VC_IMG_CELL_VS 5//九宫格纵向

@interface ImageCollectionView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView *imgCollectionView;
@property (nonatomic,strong) NSMutableArray *imgList;

@end

NS_ASSUME_NONNULL_END
