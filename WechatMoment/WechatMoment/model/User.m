//
//  User.m
//  WechatMoment
//
//  Created by panh on 2018/11/8.
//  Copyright © 2018 ph. All rights reserved.
//

#import "User.h"

@implementation User

//- (User *(^)(void))create {
//    User* (^userBlock)(void) = ^(void) {
//        return [[self alloc] init];
//    };
//   return userBlock;
//}



-(User * (^)(void))userName:(NSString *)userName{
    User * (^userBlock)(void) = ^() {
        self.userName = userName;
        return self;
    };
    return userBlock;
}


-(User * (^)(void))nick:(NSString *)nick{
    User * (^userBlock)(void) = ^() {
        self.nick = nick;
        return self;
    };
    return userBlock;
}


-(User * (^)(void))avatar:(NSString *)avatar{
    User * (^userBlock)(void) = ^() {
        self.avatar = avatar;
        return self;
    };
    return userBlock;
}

-(User * (^)(void))profileImage:(NSString *)profileImage{
    User * (^userBlock)(void) = ^() {
        self.profileImage = profileImage;
        return self;
    };
    return userBlock;
}




@end
