//
//  TableViewCellFacotry.m
//  WechatMoment
//
//  Created by panh on 2018/11/11.
//  Copyright © 2018 ph. All rights reserved.
//

#import "TableViewCellFacotry.h"
#import "ImgTableViewCell.h"
#import "TextTableViewCell.h"
#import "TextImgTableViewCell.h"
#import "ImgCommTableCiewCell.h"
#import "TextCommTableViewCell.h"
#import "AllTableViewCell.h"
@implementation TableViewCellFacotry

+ (id)sharedManager {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}


-(id)createCellByType:(ContentCellType)type TableView:(UITableView *)tableView{
    BaseContentTableViewCell *cell = nil;
    switch (type) {
        case CellTypeImg:{
            cell = (ImgTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ImgTableViewCell"];
            if(cell==nil){
                cell = [[ImgTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ImgTableViewCell"];
            }
            return cell;
        }
            break;
        case CellTypeText:{
            cell = (TextTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"TextTableViewCell"];
            if(cell==nil){
                cell = [[TextTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TextTableViewCell"];
            }
            return cell;
        }
            break;
        case CellTypeImgText:{
                cell = (TextImgTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"TextImgTableViewCell"];
                if(cell==nil){
                    cell = [[TextImgTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TextImgTableViewCell"];
                }
            return cell;
        }
            break;
        case CellTypeImgComm:{
            cell = (ImgCommTableCiewCell *)[tableView dequeueReusableCellWithIdentifier:@"ImgCommTableCiewCell"];
            if(cell==nil){
                cell = [[ImgCommTableCiewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ImgCommTableCiewCell"];
            }
            return cell;
        }
            break;
        case CellTypeTextComm:{
            cell = (TextCommTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"TextCommTableViewCell"];
            if(cell==nil){
                cell = [[TextCommTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TextCommTableViewCell"];
            }
            return cell;
        }
            break;
        case CellTypeAll:{
            cell = (AllTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"AllTableViewCell"];
            if(cell==nil){
                cell = [[AllTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AllTableViewCell"];
            }
            return cell;
        }
            break;
            
        default:
            return cell;
            break;
    }
    
}
@end
