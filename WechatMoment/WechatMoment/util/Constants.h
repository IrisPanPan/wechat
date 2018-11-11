 //
//  Constants.h
//  WechatMoment
//
//  Created by panh on 2018/11/10.
//  Copyright © 2018 ph. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#define ISIPHONEX  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width) //屏幕的宽度
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)//屏幕的高度

#define IPHONEX_BOTTOMHEIGHT (ISIPHONEX?(34.0f):(0.0f)) //iphonex底部高度

#define TOPNAV_HEIGHT (ISIPHONEX?(88.0f):(64.0f)) //状态栏和导航栏总高度
#define APPVIEW_HEIGHT (SCREEN_HEIGHT-IPHONEX_BOTTOMHEIGHT) //手机app内容区域高度
#define IPHONEX_BOTTOMHEIGHT (ISIPHONEX?(34.0f):(0.0f)) //iphonex底部高度

#define NAVBAR_FONT_SIZE (19.f) //导航栏字体大小

#define MAINSTORYBOARD_NAME @"Main"
#define STORYBOARD_NAV @"navigation"



#define  HEIGHT_BG_PROFILE 300 //个人资料背景图高度

#endif /* Constants_h */


typedef NS_ENUM(NSInteger, ContentCellType) {
    CellTypeNone,
    
    CellTypeImg,//图片
    
    CellTypeText,//文字
    
    CellTypeImgText,//图片文字
    
    CellTypeImgComm,//图片评论
    
    CellTypeTextComm,//文字评论
    
    CellTypeAll//文字图片评论
};
