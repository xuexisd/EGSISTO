//
//  ESSOViewController.m
//  埃索
//
//  Created by yeetong on 13-7-6.
//  Copyright (c) 2013年 ESSO. All rights reserved.
//

#import "ESSOViewController.h"
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"
#import "Global.h"
#import "FMDatabase.h"

@interface ESSOViewController ()

@property(strong) NSDictionary *scrollerViewData;

@end

@implementation ESSOViewController
{
    FMDatabase *TryDB;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self LoadScrollerView];
}
-(void)EScrollerViewDidClicked:(NSUInteger)index
{
    NSLog(@"index--%d",index);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)LoadScrollerView
{
    EScrollerView *scroller=[[EScrollerView alloc] initWithFrameRect:CGRectMake(0, 0, 320, 150)
                                                          ImageArray:[NSArray arrayWithObjects:@"", nil]
                                                          TitleArray:[NSArray arrayWithObjects:@"努力加载中....", nil]];
    scroller.delegate=self;
    [self.view addSubview:scroller];
    
    TryDB=[FMDatabase databaseWithPath:[Global GetLocalDBPath]];
    
    //NSDictionary *parameters = [NSDictionary dictionaryWithObject:@"" forKey:@""];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:[Global GetUrlProduct]]];
    [client registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [client setDefaultHeader:@"Accept" value:@"application/json"];
    
    [client getPath:@"GetProductTopFive"
         parameters:nil
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                self.scrollerViewData = responseObject;
                
                NSMutableArray *arrayName = [[NSMutableArray alloc] init];
                NSMutableArray *arrayImg = [[NSMutableArray alloc] init];
                int tempAdCount = 0;
                
                if([TryDB open]){
                    FMResultSet *fmAdCount = [TryDB executeQuery:@"SELECT count(*) FROM T_PRODUCT_AD"];
                    while ([fmAdCount next]) {
                        tempAdCount = [fmAdCount intForColumnIndex:0];
                    }
                    [fmAdCount close];
                }
                
                if(tempAdCount == 0){
                    if([TryDB open]){
                        for(NSDictionary *currentJsonData in self.scrollerViewData)
                        {
                            [TryDB executeUpdate:@"insert into T_PRODUCT_AD (PRODUCT_ID,PRODUCT_NAME,PRODUCT_IMG_AD,PRODUCT_VERSION) values (?,?,?,?)",[currentJsonData objectForKey:@"PRODUCT_ID"],[currentJsonData objectForKey:@"PRODUCT_NAME"],[currentJsonData objectForKey:@"PRODUCT_IMG_AD"],[currentJsonData objectForKey:@"PRODUCT_VERSION"]];
                            
                            //[currentJsonData objectForKey:@"PRODUCT_NAME"]
                            [arrayName addObject:[currentJsonData objectForKey:@"PRODUCT_NAME"]];
                            [arrayImg addObject:[currentJsonData objectForKey:@"PRODUCT_IMG_AD"]];
                        }
                    }
                    [TryDB close];
                }
                else
                {
                    //[self LoadLocalAdData];
                    if([TryDB open])
                    {
                        FMResultSet *fResultAdLocalData=[TryDB executeQuery:@"select * from T_PRODUCT_AD ORDER BY PRODUCT_ID DESC"];
                        while ([fResultAdLocalData next]) {
                            [arrayName addObject:[fResultAdLocalData stringForColumn:@"PRODUCT_NAME"]];
                            [arrayImg addObject:[fResultAdLocalData stringForColumn:@"PRODUCT_IMG_AD"]];
                        }
                        [fResultAdLocalData close];
                    }
                    [TryDB close];
                }
                EScrollerView *scroller=[[EScrollerView alloc] initWithFrameRect:CGRectMake(0, 0, 320, 150)
                                                                      ImageArray:arrayImg
                                                                      TitleArray:arrayName];
                scroller.delegate=self;
                [self.view addSubview:scroller];
            }
            failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"～错啦～"
                                   //message:[NSString stringWithFormat:@"%@",error]
                                                             message:@"网络不给力啊，请重试."
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK" otherButtonTitles:nil];

                //[GET LOCAL DATABASE].
                NSMutableArray *arrayName = [[NSMutableArray alloc] init];
                NSMutableArray *arrayImg = [[NSMutableArray alloc] init];
                if([TryDB open])
                {
                    FMResultSet *fResultAdLocalData=[TryDB executeQuery:@"select * from T_PRODUCT_AD ORDER BY PRODUCT_ID DESC"];
                    while ([fResultAdLocalData next]) {
                        [arrayName addObject:[fResultAdLocalData stringForColumn:@"PRODUCT_NAME"]];
                        [arrayImg addObject:[fResultAdLocalData stringForColumn:@"PRODUCT_IMG_AD"]];
                    }
                    [fResultAdLocalData close];
                }
                [TryDB close];
                EScrollerView *scroller=[[EScrollerView alloc] initWithFrameRect:CGRectMake(0, 0, 320, 150)
                                                                      ImageArray:arrayImg
                                                                      TitleArray:arrayName];
                scroller.delegate=self;
                [self.view addSubview:scroller];
                [av show];
            }
     ];
}
-(void)LoadLocalAdData
{
    
}

@end
