//
//  Global.h
//  埃索
//
//  Created by yeetong on 13-7-9.
//  Copyright (c) 2013年 ESSO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Global : NSObject

+(NSString *)GetUrlSunnyWCF;
+(NSString *)GetUrlUser;
+(NSString *)GetUrlProduct;
+(NSString *)GetLocalDBPath;
+(NSString *)IsLogin;
+(NSString *)EDnicaikkk;
+(NSString *)EDcaicai:(NSString*)content;

+(NSString *)MBProgressLoadingText;

@end
