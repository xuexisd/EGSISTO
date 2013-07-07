//
//  ESSOViewController.m
//  埃索
//
//  Created by yeetong on 13-7-6.
//  Copyright (c) 2013年 ESSO. All rights reserved.
//

#import "ESSOViewController.h"
#import "AFHTTPClient.h"
#import "Global.h"
#import "AFJSONRequestOperation.h"

@interface ESSOViewController ()

@property(strong) NSDictionary *scrollerViewData;

@end

@implementation ESSOViewController

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
                for(NSDictionary *currentJsonData in self.scrollerViewData)
                {
                    //[currentJsonData objectForKey:@"PRODUCT_NAME"]
                    [arrayName addObject:[currentJsonData objectForKey:@"PRODUCT_NAME"]];
                    [arrayImg addObject:[currentJsonData objectForKey:@"PRODUCT_IMG1"]];
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
                
//                EScrollerView *scroller=[[EScrollerView alloc] initWithFrameRect:CGRectMake(0, 0, 320, 150)
//                                                                      ImageArray:[NSArray arrayWithObjects:@"http://192.168.1.123/EssoHost/img/1.jpg",@"http://192.168.1.123/EssoHost/img/2.jpg",@"http://192.168.1.123/EssoHost/img/3.jpg",@"http://192.168.1.123/EssoHost/img/4.jpg",@"http://192.168.1.123/EssoHost/img/1.jpg", nil]
//                                                                      TitleArray:[NSArray arrayWithObjects:@"11",@"22",@"33",@"44",@"55", nil]];
//                scroller.delegate=self;
//                [self.view addSubview:scroller];
                
                
                //[TO DO : GET LOCAL DATABASE].
                
                [av show];
            }
     ];
}

@end
