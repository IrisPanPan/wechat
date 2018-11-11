//
//  User.h
//  WechatMoment
//  用户类
//  Created by panh on 2018/11/8.
//  Copyright © 2018 ph. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

@property(nonatomic,copy) NSString *userName;//用户名

@property(nonatomic,copy) NSString *nick;//用户昵称

@property(nonatomic,copy) NSString *avatar;//头像地址

@property(nonatomic,copy) NSString *profileImage;//个人资料图片

//+(User *)create;
//-(User *)userName:(NSString *)userName;
//-(User *)nick:(NSString *)nick;
//-(User *)avatar:(NSString *)avatar;
//-(User *)profileImage:(NSString *)profileImage;
//


//-(User * (^)(void))userName:(NSString *)userName;
//-(User * (^)(void))nick:(NSString *)nick;
//-(User * (^)(void))avatar:(NSString *)avatar;
//-(User * (^)(void))profileImage:(NSString *)profileImage;

@end

NS_ASSUME_NONNULL_END
