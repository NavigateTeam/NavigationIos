//
//  Macros.h
//  框架
//
//  Created by WangZhipeng on 16/5/18.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

//全局高度
#define KDeviceW [UIScreen mainScreen].bounds.size.width

#define KDeviceH [UIScreen mainScreen].bounds.size.height

#define KFrame(x,y,w,h) ((CGRect){{x,y},{w,h}})

#define KImageName(image)   [UIImage imageNamed:image]

#define KNSString(str)   [NSString stringWithFormat:@"%@",str]

#define KUserDefaults   [NSUserDefaults standardUserDefaults]

//颜色
#define KRGB(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define KHexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define KEY_WINDOW [[UIApplication sharedApplication] keyWindow]

//获取系统版本
#define KIOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

/**
 *  1 判断是否为3.5inch      320*480
 */
#define KScreen35 ([UIScreen mainScreen].bounds.size.height == 480)
/**
 *  2 判断是否为4inch        640*1136
 */
#define KScreen4 ([UIScreen mainScreen].bounds.size.height == 568)
/**
 *  3 判断是否为4.7inch   375*667   750*1334
 */
#define KScreen47 ([UIScreen mainScreen].bounds.size.height == 667)
/**
 *  4 判断是否为5.5inch   414*1104   1242*2208
 */
#define KScreen55 ([UIScreen mainScreen].bounds.size.height == 736)


#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"文件：%s\n行数:%d\n内容：%s\n\n\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif








#endif /* Macros_h */
