@@ 1,39 +0,0 @@
//
//  Global.m
//  埃索
//
//  Created by yeetong on 13-7-9.
//  Copyright (c) 2013年 ESSO. All rights reserved.
//

#import "Global.h"

@implementation Global

+(NSString *)GetUrlSunnyWCF
{
        return @"http://192.168.1.123/EssoHost/";
}
+(NSString *)GetUrlUser
{
        return [NSString stringWithFormat:@"%@User.svc/User/",[self GetUrlSunnyWCF]];
    }
+(NSString *)GetUrlProduct
{
        return [NSString stringWithFormat:@"%@Product.svc/Product/",[self GetUrlSunnyWCF]];
    }
+(NSString *)GetLocalDBPath
{
        NSArray *pathList=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *firstDocument=[pathList objectAtIndex:0];
        NSString *path=[firstDocument stringByAppendingPathComponent:@"EssoSQLLite.db"];
        return path;
    }


+(NSString *)MBProgressLoadingText
{
        return @"加载中...";
    }

@end