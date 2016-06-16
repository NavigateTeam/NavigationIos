//
//  URLManager.h
//  框架
//
//  Created by WangZhipeng on 16/5/18.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#ifndef URLManager_h
#define URLManager_h

//线下
//#define HOSTURL @"http://192.168.1.6:8099"

//预上线
#define HOSTURL @"http://test.qiyedp.com"


//	首页轮播列表信息
#define GetBannerInfo [NSString stringWithFormat:@"%@%@",HOSTURL,@"/api/NJXBanner/GetBannerInfo"]





#endif /* URLManager_h */
