//
//  ImageCacheMgr.m
//  WechatMoment
//
//  Created by panh on 2018/11/8.
//  Copyright © 2018 ph. All rights reserved.
//

#import "ImageMgr.h"
#import "RequestUtil.h"
@interface ImageMgr()
@property(nonatomic,strong) NSMutableDictionary *downDic;//防止重复下载
@property(nonatomic,strong) NSMutableDictionary *downFailDic;//下载失败的 不再下载
@end
@implementation ImageMgr

-(NSMutableDictionary *)downDic{
    if(_downDic==nil){
        _downDic = [NSMutableDictionary new];
    }
    return _downDic;
}

-(NSMutableDictionary *)downFailDic{
    if(_downFailDic==nil){
        _downFailDic = [NSMutableDictionary new];
    }
    return _downFailDic;
}

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
        _imageCache = [ImageCache sharedImageCache];
        _imageDownloader = [ImageDownloader sharedDownloader];
        [self downFailDic];
        [self downDic];
    }
    return self;
}


- (void)downloadImageWithURL:(NSString *)url PlaceHolderImgName:(NSString *)placeholder completed:(ImageCompletionBlock)completedBlock{
    if([self.downDic.allKeys containsObject:url]){
        return;
    }
    if([self.downFailDic.allKeys containsObject:url]){
        completedBlock([UIImage imageNamed:placeholder],url);
        return;
    }
    if(url==nil || url.isEmptyStr){
        completedBlock([UIImage imageNamed:placeholder],url);
        return;
    }
    
    UIImage *img =  [self.imageCache getImageFromCacheByUrl:url];
    if(img == nil){
        NSString *destDir = [self.imageCache diskCachePath];
        img = [self.imageCache getImageFromDisk:url];
        if(img == nil){
            [self.downDic setObject:@"download" forKey:url];
            [RequestUtil downloadFileFromServer:url DesPath:destDir Completion:^(NSString * _Nonnull result) {
                [self.downDic removeObjectForKey:url];
                NSString *filePath = result;
                UIImage *downImg =[UIImage imageWithContentsOfFile:filePath];
                if(downImg != nil){
                    [self.imageCache saveImageOnDisk:downImg Url:url];
                    [self.imageCache saveImageToCathe:img Url:url];
                }else{
                    [self.downFailDic setObject:@"fail" forKey:url];
                    downImg = [UIImage imageNamed:placeholder];
                }
                if(completedBlock){
                    completedBlock(downImg,url);
                }
            }];
        }else{
            [self.imageCache saveImageToCathe:img Url:url];
             completedBlock(img,url);
        }
    }else{
        completedBlock(img,url);
    }
   
}






@end
