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
#import "UIImageView+AFNetworking.h"
#import "ESSOProductDetailViewController.h"
#import "StackMenu/PCStackMenu.h"
#import "StackMenu/PCStackMenuItem.h"

@interface ESSOViewController ()

@property(strong) NSDictionary *scrollerViewData;

@end

@implementation ESSOViewController
{
    NSDictionary *homeTableData;
    NSMutableArray *homeTableImg;
    NSMutableArray *homeTableName;
    NSMutableArray *homeTablePrice;
    NSMutableArray *homeTableProductId;
}
@synthesize homeTableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    homeTableImg = [[NSMutableArray alloc]init];
    homeTableName = [[NSMutableArray alloc]init];
    homeTablePrice = [[NSMutableArray alloc]init];
    homeTableProductId = [[NSMutableArray alloc]init];
    [self LoadScrollView];
    [self LoadHomeTableData];
    [self setPage];
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
                    scrollviewerSuccess.autoScrollDelayTime=3.0;
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
                    [homeTableProductId addObject:[currentJsonData objectForKey:@"PRODUCT_ID"]];
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
    return [homeTableData count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tryTableIdentifier = @"ESSOProductTableCell";
    __weak ESSOProductTableCell *cell=(ESSOProductTableCell *)[homeTableView dequeueReusableCellWithIdentifier:tryTableIdentifier];
    if(cell==nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ESSOProductTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
//    cell.img = [[UIImageView alloc]initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[homeTableImg objectAtIndex:indexPath.row]]]]];
    cell.lblName.text = [homeTableName objectAtIndex:indexPath.row];
    cell.lblPrice.text = [[NSString alloc] initWithFormat:@"%@",[homeTablePrice objectAtIndex:indexPath.row]];
    [cell.img setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[homeTableImg objectAtIndex:indexPath.row]]]
                          placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                       cell.img.image = image;
                                       
                                       //only required if no placeholder is set to force the imageview on the cell to be laid out to house the new image.
                                       //if(weakCell.imageView.frame.size.height==0 || weakCell.imageView.frame.size.width==0 ){
//                                       [cell setNeedsLayout];
                                       //}
                                   }
                                   failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                       
                                   }];

//    CGSize size = CGSizeMake(cell.lblName.frame.size.width, 45);
//    CGSize labelsize = [cell.lblName.text sizeWithFont:cell.lblName.font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
//    [cell.lblName setFrame:CGRectMake(cell.lblName.frame.origin.x, cell.lblName.frame.origin.y, labelsize.width, labelsize.height)];
//    [cell setNeedsLayout];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    ESSOProductDetailViewController *next = [board instantiateViewControllerWithIdentifier:@"ESSOProductDetailViewController"];
    next.PRODUCT_ID = [[homeTableProductId objectAtIndex:indexPath.row] integerValue];
    next.PRODUCT_NAME = [homeTableName objectAtIndex:indexPath.row];
//    next.PRODUCT_PRICE = [[homeTablePrice objectAtIndex:indexPath.row] floatValue];
    next.img1URL = [homeTableImg objectAtIndex:indexPath.row];
    next.displayPrice = [homeTablePrice objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:next animated:YES];
    [homeTableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)btnCategoryGo:(id)sender {
//    UIStoryboard *board = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
//    UIViewController *next = [board instantiateViewControllerWithIdentifier:@"ESSOProductDetailViewController"];
//    [self.navigationController pushViewController:next animated:YES];
    
}

-(void)setPage
{
    UIButton *btnRigth= [[UIButton alloc]initWithFrame:CGRectMake(255, self.view.frame.size.height - 111, 39, 45)];
    [btnRigth addTarget:self action:@selector(stackMenu:) forControlEvents:UIControlEventTouchUpInside];
    [btnRigth setBackgroundImage:[UIImage imageNamed:@"StackMenu_start@2x.png"] forState:UIControlStateNormal];
	[self.view addSubview:btnRigth];
}

- (IBAction)stackMenu:(id)sender
{
	UIButton *button = (UIButton *)sender;
	PCStackMenu *stackMenu = [[PCStackMenu alloc] initWithTitles:[NSArray arrayWithObjects:@"主页", @"搜索", @"分享", nil]
													  withImages:[NSArray arrayWithObjects:[UIImage imageNamed:@"StackMenu_start@2x.png"], [UIImage imageNamed:@"StackMenu_search@2x.png"], [UIImage imageNamed:@"StackMenu_share@2x.png"], nil]
													atStartPoint:CGPointMake(button.frame.origin.x + button.frame.size.width, button.frame.origin.y)
														  inView:self.view
													  itemHeight:40
												   menuDirection:PCStackMenuDirectionClockWiseUp];
	for(PCStackMenuItem *item in stackMenu.items)
		item.stackTitleLabel.textColor = [UIColor orangeColor];
    
	[stackMenu show:^(NSInteger selectedMenuIndex) {
		NSLog(@"menu index : %d", selectedMenuIndex);
        if(selectedMenuIndex == 0)
        {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
	}];
}

@end
