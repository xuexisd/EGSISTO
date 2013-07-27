//
//  Global.m
//  埃索
//
//  Created by yeetong on 13-7-9.
//  Copyright (c) 2013年 ESSO. All rights reserved.
//

#import "Global.h"
#import "FMDatabase.h"

@implementation Global
{
}

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
+(NSString *)IsLogin
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMM"];
    int expiry = 0;
    int nowDate = [[formatter stringFromDate: [NSDate date]] intValue];
    
    FMDatabase *TryDB;
    TryDB=[FMDatabase databaseWithPath:[Global GetLocalDBPath]];
    if([TryDB open])
    {
        FMResultSet *fResultAdLocalData=[TryDB executeQuery:@"select * from T_LOGIN"];
        while ([fResultAdLocalData next]) {
            expiry = [[fResultAdLocalData stringForColumn:@"LOGIN_EXPIRY"] intValue];
        }
        [fResultAdLocalData close];
    }
    [TryDB close];
    if (expiry < nowDate) {
        return @"0";
    }
    else
    {
        return @"1";
    }
}
+(NSString *)EDnicaikkk
{
    return @"!EDEF$7ESSOT%^U^&U*T^#$Tfer35342d#R##$TG$^TFW";
}

+(NSString *)EDcaicai:(NSString*)content{
    NSString *result=[NSString string];
    for(int i=0; i < [content length]; i++){
        int chData=[content characterAtIndex:i];
        for(int j=0;j<[[self EDnicaikkk] length];j++){
            int chKey=[[self EDnicaikkk] characterAtIndex:j];
            chData=chData^chKey;
        }
        result=[NSString stringWithFormat:@"%@%@",result,[NSString stringWithFormat:@"%c",chData]];
    }
    return result;
}

+(NSString *)MBProgressLoadingText
{
    return @"加载中...";
}

@end