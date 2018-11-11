//
//  TwContent.m
//  WechatMoment
//
//  Created by panh on 2018/11/8.
//  Copyright © 2018 ph. All rights reserved.
//

#import "TwContent.h"

@implementation TwContent

+(TwContent *)create{
    TwContent *content = [[self alloc] init];
    return  content;
}

-(TwContent *)content:(NSString *)content{
    self.content = content;
    return self;
}

-(TwContent *)sender:(User *)sender{
    self.sender = sender;
    return  self;
}

-(TwContent *)commentList:(NSMutableArray *)commentList{
    self.commentList = commentList;
    return self;
}

@end
