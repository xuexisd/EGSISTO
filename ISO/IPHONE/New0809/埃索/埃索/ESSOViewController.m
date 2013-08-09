//
//  ESSOViewController.m
//  埃索
//
//  Created by yeetong on 13-8-9.
//  Copyright (c) 2013年 ESSO. All rights reserved.
//

#import "ESSOViewController.h"
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"
#import "Global.h"
#import "ESSOProductTableCell.h"

@interface ESSOViewController ()

@property(strong) NSDictionary *scrollerViewData;

@end

@implementation ESSOViewController
{
    NSDictionary *homeTableData;
    NSMutableArray *homeTableImg;
    NSMutableArray *homeTableName;
    NSMutableArray *homeTablePrice;
}
@synthesize homeTableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    homeTableImg = [[NSMutableArray alloc]init];
    homeTableName = [[NSMutableArray alloc]init];
    homeTablePrice = [[NSMutableArray alloc]init];
    [self LoadScrollView];
    [self LoadHomeTableData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)LoadScrollView
{
    UILabel *lblLoadingScrollView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 150)];
    lblLoadingScrollView.text = @"加载中....";
    lblLoadingScrollView.textAlignment = NSTextAlignmentCenter;
    UILabel *lblFailScrollView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 150)];
    lblFailScrollView.text = @"网络不给力啊，请重试。";
    lblFailScrollView.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:lblLoadingScrollView];
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:[Global GetUrlProduct]]];
    [client registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [client setDefaultHeader:@"Accept" value:@"application/json"];
    
    [client getPath:@"GetProductTopFive"
         parameters:nil
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                self.scrollerViewData = responseObject;
                
                NSMutableArray *internetViewsArray = [[NSMutableArray alloc] init];
                for(NSDictionary *currentJsonData in self.scrollerViewData)
                {
                    [internetViewsArray addObject:[[UIImageView alloc]initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[currentJsonData objectForKey:@"PRODUCT_IMG_AD"]]]]]];
                }
                [lblLoadingScrollView removeFromSuperview];
                [lblFailScrollView removeFromSuperview];
                if([internetViewsArray count] > 0)
                {
                    JScrollView_PageControl_AutoScroll *scrollviewerSuccess=[[JScrollView_PageControl_AutoScroll alloc]initWithFrame:CGRectMake(0, 0, 320, 150)];
                    scrollviewerSuccess.autoScrollDelayTime=2.0;
                    scrollviewerSuccess.delegate=self;
                    [scrollviewerSuccess setViewsArray:internetViewsArray];
                    [self.view addSubview:scrollviewerSuccess];
                    [scrollviewerSuccess shouldAutoShow:YES];
                }
                else
                {
                    UILabel *lblNullScrollView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 150)];
                    lblNullScrollView.text = @"亲，暂时没有任何数据哦。";
                    lblNullScrollView.textAlignment = NSTextAlignmentCenter;
                    [self.view addSubview:lblNullScrollView];
                }
            }
            failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                message:[NSString stringWithFormat:@"%@",error]
                [lblLoadingScrollView removeFromSuperview];
                [self.view addSubview:lblFailScrollView];
            }
     ];
}


- (void)didClickPage:(JScrollView_PageControl_AutoScroll *)view atIndex:(NSInteger)index
{
    NSLog(@"click at %d",index  );
}

-(void)LoadHomeTableData
{
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:[Global GetUrlProduct]]];
    [client registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [client setDefaultHeader:@"Accept" value:@"application/json"];
    
    [client getPath:@"GetProductHome"
         parameters:nil
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                homeTableData = responseObject;
                
                for(NSDictionary *currentJsonData in homeTableData)
                {
//                    [homeTableImg addObject:[[UIImageView alloc]initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[currentJsonData objectForKey:@"PRODUCT_IMG_AD"]]]]]];
                    [homeTableImg addObject:[currentJsonData objectForKey:@"PRODUCT_IMG1"]];
                    [homeTableName addObject:[currentJsonData objectForKey:@"PRODUCT_NAME"]];
                    [homeTablePrice addObject:[currentJsonData objectForKey:@"PRODUCT_PRICE"]];
                }
                [homeTableView reloadData];
            }
            failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                //                message:[NSString stringWithFormat:@"%@",error]
            }
     ];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%d",[homeTableData count]);
    return [homeTableData count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tryTableIdentifier = @"ESSOProductTableCell";
    ESSOProductTableCell *cell=(ESSOProductTableCell *)[homeTableView dequeueReusableCellWithIdentifier:tryTableIdentifier];
    if(cell==nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ESSOProductTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.img = [[UIImageView alloc]initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[homeTableImg objectAtIndex:indexPath.row]]]]];
    cell.lblName.text = [homeTableName objectAtIndex:indexPath.row];
    cell.lblPrice.text = [[NSString alloc] initWithFormat:@"%@",[homeTablePrice objectAtIndex:indexPath.row]];
    return cell;
}

@end
