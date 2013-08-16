//
//  ESSOProductListViewController.m
//  埃索
//
//  Created by yeetong on 13-8-15.
//  Copyright (c) 2013年 ESSO. All rights reserved.
//

#import "ESSOProductListViewController.h"
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"
#import "Global.h"
#import "UIImageView+AFNetworking.h"
#import "StackMenu/PCStackMenu.h"
#import "StackMenu/PCStackMenuItem.h"
#import "ESSOProductTableCell.h"
#import "ESSOProductDetailViewController.h"

@interface ESSOProductListViewController ()

@end

@implementation ESSOProductListViewController
{
    NSDictionary *listData;
    NSMutableArray *homeTableImg;
    NSMutableArray *homeTableName;
    NSMutableArray *homeTablePrice;
    NSMutableArray *homeTableProductId;
    int lastRow;
}

@synthesize CategoryName;
@synthesize categoryTag;
@synthesize listTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    homeTableImg = [[NSMutableArray alloc]init];
    homeTableName = [[NSMutableArray alloc]init];
    homeTablePrice = [[NSMutableArray alloc]init];
    homeTableProductId = [[NSMutableArray alloc]init];
    self.title = [Global GetCateGoryNameBasePinYing:categoryTag];
    [self setPage];
    [self LoadListTableData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)LoadListTableData
{
    NSMutableDictionary *parameters=[[NSMutableDictionary alloc] init];
    [parameters setObject:[[NSString alloc]initWithFormat:@"%@",CategoryName] forKey:@"productCategory"];
    [parameters setObject:[[NSString alloc]initWithFormat:@"%d",lastRow] forKey:@"lastRow"];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:[Global GetUrlProduct]]];
    [client registerHTTPOperationClass:[AFJSONRequestOperation class]];
    client.parameterEncoding = AFJSONParameterEncoding;
    [client setDefaultHeader:@"Accept" value:@"application/json"];
    
    [client getPath:@"GetProductByRowNumber"
         parameters:parameters
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                listData = responseObject;
                
                for(NSDictionary *currentJsonData in listData)
                {
                    [homeTableImg addObject:[currentJsonData objectForKey:@"PRODUCT_IMG1"]];
                    [homeTableName addObject:[currentJsonData objectForKey:@"PRODUCT_NAME"]];
                    [homeTablePrice addObject:[currentJsonData objectForKey:@"PRODUCT_PRICE"]];
                    [homeTableProductId addObject:[currentJsonData objectForKey:@"PRODUCT_ID"]];
                }
                [listTableView reloadData];
            }
            failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"%@",[NSString stringWithFormat:@"%@",error]);
            }
     ];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listData count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tryTableIdentifier = @"ESSOProductTableCell";
    __weak ESSOProductTableCell *cell=(ESSOProductTableCell *)[listTableView dequeueReusableCellWithIdentifier:tryTableIdentifier];
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
    [listTableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)setPage
{
    UIButton *btnRigth= [[UIButton alloc]initWithFrame:CGRectMake(255, self.view.frame.size.height - 111, 39, 45)];
    [btnRigth addTarget:self action:@selector(stackMenu:) forControlEvents:UIControlEventTouchUpInside];
    [btnRigth setBackgroundImage:[UIImage imageNamed:@"StackMenu_start@2x.png"] forState:UIControlStateNormal];
	[self.view addSubview:btnRigth];
    lastRow = 0;
}

- (IBAction)stackMenu:(id)sender
{
	UIButton *button = (UIButton *)sender;
	PCStackMenu *stackMenu = [[PCStackMenu alloc] initWithTitles:[NSArray arrayWithObjects:@"首页", @"搜索", @"分享", nil]
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
