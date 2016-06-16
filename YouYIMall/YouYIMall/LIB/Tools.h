//
//  Tools.h
//  框架
//
//  Created by WangZhipeng on 16/5/18.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Tools : NSObject

//方法功能：根据字体大小与限宽，计算高度
-(CGFloat)getHeightWithString:(NSString*)string fontSize:(CGFloat)fontSize maxWidth:(CGFloat)maxWidth;

-(CGFloat)getWidthWithString:(NSString*)string fontSize:(CGFloat)fontSize maxHeight:(CGFloat)maxHeight;

// 生成指定大小的图片
- (UIImage *)scaleImageToSize:(NSString*)imageName size:(CGSize)newsize;

// 生成一张指定颜色的图片
+ (UIImage *)imageWithColor:(UIColor*)color size:(CGSize)newsize;

@end
