//
//  ImageCache.m
//  WechatMoment
//
//  Created by panh on 2018/11/8.
//  Copyright © 2018 ph. All rights reserved.
//

#import "ImageCache.h"

#define MAX_CACHE 100 //最大缓存量
#define IMG_NAMESPACE @"IMAGESPACE"


@interface ImageCache()<NSCacheDelegate>

@property (strong,nonatomic) NSFileManager *fileMgr;

@property (strong, nonatomic) NSCache *memCache;//内存

@property (strong, nonatomic) dispatch_queue_t ioQueue;


@end

@implementation ImageCache


+ (ImageCache *)sharedImageCache {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}


-(id)init{
    self = [super init];
    if (self) {
        [self memCache];
        [self initDiskCache];
      
    }
    return self;
}




#pragma mark Memery Cache

-(NSCache *)memCache{
    if (_memCache == nil) {
        _memCache = [[NSCache alloc] init];
        _memCache.countLimit = MAX_CACHE;  // 设置了存放对象的最大数量
        _memCache.name = IMG_NAMESPACE;
        _memCache.delegate = self;
    }
    return _memCache;
}

-(void)saveImageToCathe:(UIImage *)image Url:(NSString *)urlStr{
    if(!urlStr.isEmptyStr){
        [self.memCache setObject:image forKey:urlStr];
    }
}

-(UIImage *)getImageFromCacheByUrl:(NSString *)urlStr{
    return  [self.memCache objectForKey:urlStr];
}

/**
 清空所有内存缓存
 */
-(void)clearAllMemCache{
    [self.memCache removeAllObjects];
}


#pragma mark NSCache Delegate
-(void)cache:(NSCache *)cache willEvictObject:(id)obj{
    NSLog(@"要删除的对象obj-------------%@", obj);
}




#pragma mark Disk Cache
-(NSString *)diskCachePath{
    if(_diskCachePath==nil){
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        _diskCachePath = [paths[0] stringByAppendingPathComponent:IMG_NAMESPACE];
    }
    return  _diskCachePath;
}

-(void)initDiskCache{
    _ioQueue = dispatch_queue_create("img_cache_queue", DISPATCH_QUEUE_SERIAL);
    [self diskCachePath];
    _fileMgr = [NSFileManager new];
}






-(UIImage *)getImageFromDisk:(NSString *)urlStr{
    NSString *key = [Util getMD5Str:urlStr];
    NSString *fileDir = [self.diskCachePath stringByAppendingPathComponent:key];
    if([self isFileExist:fileDir]){
        NSArray *fileItems = [self getFileItemNames:fileDir];
        if((fileItems!=nil) && (fileItems.count>0)){
            NSString *fileName = [fileItems objectAtIndex:0];
            NSString *filePath = [fileDir stringByAppendingPathComponent:fileName];
            UIImage *img = [UIImage imageWithContentsOfFile:filePath];
            return img;
        }
       
    }
    return nil;
}


-(NSArray *)getFileItemNames:(NSString *)filePath{
    NSError *error;
    NSArray *fileList = [[NSArray alloc] init];
    if([self.fileMgr fileExistsAtPath:filePath]){
        //fileList便是包含有该文件夹下所有文件的文件名及文件夹名的数组
        fileList = [self.fileMgr contentsOfDirectoryAtPath:filePath error:&error];
    }
    return fileList;
}


-(BOOL)isFileExist:(NSString *)filePath{
    //先判断这个文件夹是否存在
    if (![self.fileMgr fileExistsAtPath:filePath]) {
        return NO;
    }else{
        return YES;
    }
    
}


-(void)saveImageOnDisk:(UIImage *)image Url:(NSString *)urlStr{
    CGSize size = image.size;
    if(size.width>1500||size.height>1500){
        image = [Util CompressImage:image targetWidth:1500];
    }
    NSData *data = UIImageJPEGRepresentation(image, 1.0);//UIImagePNGRepresentation 耗时
    NSString *key = [Util getMD5Str:urlStr];
    NSString *fileName = [NSString stringWithFormat:@"%@.%@",key,[Util getTypeForImageData:data]];
    NSString *filePath =  [[self.diskCachePath stringByAppendingPathComponent:key] stringByAppendingPathComponent:fileName];
    [data writeToFile:filePath atomically:YES];
}


- (void)clearDisk{
    dispatch_async(self.ioQueue, ^{
        [self.fileMgr removeItemAtPath:self.diskCachePath error:nil];
        [self.fileMgr createDirectoryAtPath:self.diskCachePath
                withIntermediateDirectories:YES
                                 attributes:nil
                                      error:NULL];
    });
}

@end
