//
//  SubViewFrame.m
//  SinaWeiBo
//
//  Created by ADAQM on 16/5/9.
//  Copyright © 2016年 ZGD. All rights reserved.
//

#import "SubViewFrame.h"
#import "HomeTableViewCell.h"
#import "Status.h"
#import "User.h"
// cell的边框宽度
#define HWStatusCellBorderW 10
@implementation SubViewFrame

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font
{
    return [self sizeWithText:text font:font maxW:MAXFLOAT];
}

- (void)setStatues:(Status *)statues
{
    _statues = statues;
    
    
    User *user = statues.user;
    
    // cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    /* 原创微博 */
    /**
     *  头像
     */
    CGFloat iconWH = 35;
    CGFloat iconX = HWStatusCellBorderW;
    CGFloat iconY = HWStatusCellBorderW;
    self.iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
    /**
     *  昵称
     */
    CGFloat nameX = CGRectGetMaxX(self.iconViewF);
    CGFloat nameY = iconY;
    CGSize nameSize = [self sizeWithText:user.name font:HWStatusCellNameFont];
    self.nameLabelF = (CGRect){{nameX, nameY}, nameSize};
    /**
     *  会员图标
     */
    if (user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF) + HWStatusCellBorderW;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = 14;
        self.vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    /** 时间 */
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF) + HWStatusCellBorderW;
    CGSize timeSize = [self sizeWithText:statues.created_at font:HWStatusCellTimeFont];
    self.timeLabelF = (CGRect){{timeX, timeY}, timeSize};
    
    /** 来源 */
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF) + HWStatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [self sizeWithText:statues.source font:HWStatusCellSourceFont];
    self.sourceLabelF = (CGRect){{sourceX, sourceY}, sourceSize};
    
    /** 正文 */
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabelF)) + HWStatusCellBorderW;
    CGFloat maxW = cellW - 2 * contentX;
    CGSize contentSize = [self sizeWithText:statues.text font:HWStatusCellContentFont maxW:maxW];
    self.contentLabelF = (CGRect){{contentX, contentY}, contentSize};
    /** 配图 */
    CGFloat originalH = 0;
    if (statues.pic_urls.count) { // 有配图
        CGFloat photoWH = 100;
        CGFloat photoX = contentX;
        CGFloat photoY = CGRectGetMaxY(self.contentLabelF) + HWStatusCellBorderW;
        self.photoViewF = CGRectMake(photoX, photoY, photoWH, photoWH);
        
        originalH = CGRectGetMaxY(self.photoViewF) + HWStatusCellBorderW;
    } else { // 没配图
        originalH = CGRectGetMaxY(self.contentLabelF) + HWStatusCellBorderW;
    }

    /** 原创微博整体 */
    CGFloat originalX = 0;
    CGFloat originalY = 0;
    CGFloat originalW = cellW;
    self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    if (statues.retweeted_status) {
        Status *retweeted_status = statues.retweeted_status;
        User *retweeted_status_user = retweeted_status.user;
        /** 被转发微博正文 */
        CGFloat retweetContentX = HWStatusCellBorderW;
        CGFloat retweetContentY = HWStatusCellBorderW;
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@", retweeted_status_user.name, retweeted_status.text];
        CGSize retweetContentSize = [self sizeWithText:retweetContent font:HWStatusCellRetweetContentFont maxW:maxW];
        self.retweetContentLabelF = (CGRect){{retweetContentX, retweetContentY}, retweetContentSize};
        /** 被转发微博配图 */
        CGFloat retweetH = 0;
        if (retweeted_status.pic_urls.count) { // 转发微博有配图
            CGFloat retweetPhotoWH = 100;
            CGFloat retweetPhotoX = retweetContentX;
            CGFloat retweetPhotoY = CGRectGetMaxY(self.retweetContentLabelF) + HWStatusCellBorderW;
            self.retweetPhotoViewF = CGRectMake(retweetPhotoX, retweetPhotoY, retweetPhotoWH, retweetPhotoWH);
            
            retweetH = CGRectGetMaxY(self.retweetPhotoViewF) + HWStatusCellBorderW;
        } else { // 转发微博没有配图
            retweetH = CGRectGetMaxY(self.retweetContentLabelF) + HWStatusCellBorderW;
        }
        
        /** 被转发微博整体 */
        CGFloat retweetX = 0;
        CGFloat retweetY = CGRectGetMaxY(self.originalViewF);
        CGFloat retweetW = cellW;
        self.retweetViewF = CGRectMake(retweetX, retweetY, retweetW, retweetH);
        
//        self.cellHeight = CGRectGetMaxY(self.retweetViewF);
        self.toolbarF = CGRectMake(retweetX, CGRectGetMaxY(self.retweetViewF), cellW, 35);
    }else
    {
//        self.cellHeight = CGRectGetMaxY(self.originalViewF);
        self.toolbarF = CGRectMake(0, CGRectGetMaxY(self.originalViewF), cellW, 35);
    }
    self.cellHeight = CGRectGetMaxY(self.toolbarF);
}

@end
