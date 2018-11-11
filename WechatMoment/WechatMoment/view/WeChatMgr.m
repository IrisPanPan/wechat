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

+ (id)sharedManager {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}


- (id)init {
    if ((self = [super init])) {
        _pageIndex = 0;
        _user = [User new];
        _allTwList = [NSMutableArray new];
        _twList = [NSArray new];
    }
    return self;
}




/**
 分页查询
 */
-(void)getTwList{
    if(self.allTwList.count>(_pageIndex+1)*LIST_PAGE_SIZE){
        NSArray *tmpList = [self.allTwList subarrayWithRange:NSMakeRange(0, (_pageIndex+1)*LIST_PAGE_SIZE)];
        self.twList = tmpList;
    }else{
        self.twList = [self.allTwList copy];
    }
}

/**
 获取cell 类型
 */
-(ContentCellType)getCellTypeByTwContent:(TwContent *)twContent{
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

-(NSString *)getCellIDStrByCellType:(ContentCellType)cellType{
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
-(void)downloadTweetsListCallback:(void (^)(id result))callback {
    [RequestUtil sendRequestToServer:@"http://thoughtworks-ios.herokuapp.com/user/jsmith/tweets" Parameters:nil TimeOut:30 Success:^(id  _Nonnull result) {
        NSMutableArray *resultAry = result;
        if(resultAry){
            self.allTwList = [self parse2TwContentList:resultAry];
            [self getTwList];
        }
        callback(result);
    } Fail:^(NSString * _Nonnull result) {
        
    }];
}




-(NSMutableArray *)parse2TwContentList:(NSArray *)array{
    NSMutableArray *list = [NSMutableArray new];
    if(array==nil){
        return list;
    }
    TwContent *twcontent;
    for(NSInteger i = 0,len = array.count;i<len;i++){
        NSDictionary *dic = [array objectAtIndex:i];
        twcontent = [TwContent new];
        twcontent.content = [dic objectForKey:@"content"];
        if([dic objectForKey:@"sender"]){
            NSDictionary *userDic = [dic objectForKey:@"sender"];
            User *user = [User new];
            user.userName = [userDic objectForKey:@"username"];
            user.nick = [userDic objectForKey:@"nick"];
            user.avatar = [userDic objectForKey:@"avatar"];
            twcontent.sender = user;
        }
        
        if([dic objectForKey:@"images"]){
            NSMutableArray *imglist = [NSMutableArray new];
            NSArray *imgAry = [dic objectForKey:@"images"];
            for(NSInteger j = 0,len = imgAry.count;j<len;j++){
                NSString *url = [[imgAry objectAtIndex:j] objectForKey:@"url"];
                [imglist addObject:url];
            }
            twcontent.imgList = imglist;
        }
        
        if([dic objectForKey:@"comments"]){
            NSArray *commAry = [dic objectForKey:@"comments"];
            twcontent.commentList = [self parse2TwContentList:commAry];
        }
        
        if((![dic.allKeys containsObject:@"error"])&&(![dic.allKeys containsObject:@"unknown error"]&&
                                                      (([dic.allKeys containsObject:@"content"])||([dic.allKeys containsObject:@"images"])))){
            twcontent.cellType = [self getCellTypeByTwContent:twcontent];
            [list addObject:twcontent];
        }
        
    }
    return list;
    
}


/**
 下载个人信息
 */
-(void)downLoadUserInfoCallback:(void (^)(id result))callback{
    [RequestUtil sendRequestToServer:@"http://thoughtworks-ios.herokuapp.com/user/jsmith" Parameters:nil TimeOut:30 Success:^(id  _Nonnull result) {
        NSMutableDictionary *resultDic = result;
        if(resultDic){
            self.user.userName = [resultDic objectForKey:@"username"];
            self.user.nick = [resultDic objectForKey:@"nick"];
            self.user.avatar = [resultDic objectForKey:@"avatar"];
            self.user.profileImage = [resultDic objectForKey:@"profile-image"];
        }
        callback(result);
    } Fail:^(NSString * _Nonnull result) {
        
    }];
}


@end
