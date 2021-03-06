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

+(NSString *)GetCateGoryName:(int)tag{
    NSString *result=[NSString string];
    switch (tag) {
        case 20:
            result = @"kafei";
            break;
        case 21:
            result = @"songbing";
            break;
        case 22:
            result = @"mitangtusi";
            break;
        case 23:
            result = @"tianpin";
            break;
        case 24:
            result = @"shabing";
            break;
        case 25:
            result = @"yimian";
            break;
        case 26:
            result = @"naicha";
            break;
        case 27:
            result = @"zhongshitaocan";
            break;
        case 28:
            result = @"xishitaocan";
            break;
        case 29:
            result = @"tang";
            break;
        default:
            break;
    }
    return result;
}

+(NSString *)GetCateGoryNameBasePinYing:(int)tag{
    NSString *result=[NSString string];
    switch (tag) {
        case 20:
            result = @"咖啡";
            break;
        case 21:
            result = @"松饼";
            break;
        case 22:
            result = @"蜜糖吐司";
            break;
        case 23:
            result = @"甜品";
            break;
        case 24:
            result = @"沙冰";
            break;
        case 25:
            result = @"意面";
            break;
        case 26:
            result = @"奶茶";
            break;
        case 27:
            result = @"中式套餐";
            break;
        case 28:
            result = @"西式套餐";
            break;
        case 29:
            result = @"汤";
            break;
        default:
            break;
    }
    return result;
}

+(NSString *)MBProgressLoadingText
{
    return @"加载中...";
}

@end