//
//  Tools.m
//  框架
//
//  Created by WangZhipeng on 16/5/18.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "Tools.h"

@implementation Tools

#pragma mark --长度宽度相关方法

//方法功能：根据字体大小与限宽，计算高度
-(CGFloat)getHeightWithString:(NSString*)string fontSize:(CGFloat)fontSize maxWidth:(CGFloat)maxWidth
{
    return [self getHeightWithString:string font:[UIFont systemFontOfSize:fontSize] maxWidth:maxWidth];
}

-(CGFloat)getHeightWithString:(NSString*)string font:(UIFont *)font maxWidth:(CGFloat)maxWidth
{
    return [self getSizeWithString:string font:font size:CGSizeMake(maxWidth, MAXFLOAT)].height;
}

//方法功能：根据字体大小与限高，计算宽度
-(CGFloat)getWidthWithString:(NSString*)string fontSize:(CGFloat)fontSize maxHeight:(CGFloat)maxHeight
{
    return [self getWidthWithString:string font:[UIFont systemFontOfSize:fontSize] maxHeight:maxHeight];
}

-(CGFloat)getWidthWithString:(NSString*)string font:(UIFont *)font maxHeight:(CGFloat)maxHeight
{
    return [self getSizeWithString:string font:font size:CGSizeMake(MAXFLOAT, maxHeight)].width;
}

-(CGSize)getSizeWithString:(NSString*)string font:(UIFont *)font size:(CGSize)size
{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    return [string boundingRectWithSize:size
                              options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin
                           attributes:attribute context:nil].size;
}


// 生成指定大小的图片
- (UIImage *)scaleImageToSize:(NSString*)imageName size:(CGSize)newsize
{
    UIImage *image = [UIImage imageNamed:imageName];
    UIGraphicsBeginImageContext(newsize);
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, newsize.width, newsize.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;

}

// 生成一张指定颜色的图片
+ (UIImage *)imageWithColor:(UIColor*)color size:(CGSize)imageSize
{
    CGRect rect = (CGRect){{0,0},{imageSize.width,imageSize.height}};
    UIGraphicsBeginImageContext(imageSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


























@end
