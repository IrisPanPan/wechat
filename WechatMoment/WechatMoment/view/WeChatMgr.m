//
//  WeChatMgr.m
//  WechatMoment
//
//  Created by panh on 2018/11/11.
//  Copyright © 2018 ph. All rights reserved.
//

#import "WeChatMgr.h"
#import "RequestUtil.h"

@implementation WeChatMgr
/**
 获取cell 类型
 */
+(ContentCellType)getCellTypeByTwContent:(TwContent *)twContent{
    if(twContent.content==nil || twContent.content.isEmptyStr){
        if(twContent.imgList==nil || twContent.imgList.count==0){
            return CellTypeNone;
        }else{
            if(twContent.commentList==nil || twContent.commentList.count==0){
                return CellTypeImg;
            }else{
                return CellTypeImgComm;
            }
            
        }
    }else{
        if(twContent.imgList==nil || twContent.imgList.count==0){
            if(twContent.commentList==nil || twContent.commentList.count==0){
                return CellTypeText;
            }else{
                return CellTypeTextComm;
            }
        }else{
            if(twContent.commentList==nil || twContent.commentList.count==0){
                return CellTypeImgText;
            }else{
                return CellTypeAll;
            }
            
        }
        
    }
}

+(NSString *)getCellIDStrByCellType:(ContentCellType)cellType{
    switch (cellType) {
        case CellTypeImg:
            return @"ImgTableViewCell";
            break;
        case CellTypeText:
            return @"TextTableViewCell";
            break;
        case CellTypeImgText:
            return @"TextImgTableViewCell";
            break;
        case CellTypeImgComm:
            return @"ImgCommTableCiewCell";
            break;
        case CellTypeTextComm:
            return @"TextCommTableViewCell";
            break;
        case CellTypeAll:
            return @"AllTableViewCell";
            break;
            
        default:
            return @"";
            break;
    }
}



/**
 下载微信朋友圈列表
 */
+(void)downloadTweetsListCallback:(void (^)(id result))callback {
    [RequestUtil sendRequestToServer:@"http://thoughtworks-ios.herokuapp.com/user/jsmith/tweets" Parameters:nil TimeOut:30 Success:^(id  _Nonnull result) {
        callback(result);
    } Fail:^(NSString * _Nonnull result) {
        
    }];
}



/**
 下载个人信息
 */
+(void)downLoadUserInfoCallback:(void (^)(id result))callback{
    [RequestUtil sendRequestToServer:@"http://thoughtworks-ios.herokuapp.com/user/jsmith" Parameters:nil TimeOut:30 Success:^(id  _Nonnull result) {
        callback(result);
    } Fail:^(NSString * _Nonnull result) {
        
    }];
}


@end
