//
//  ESSOProductDetailViewController.m
//  埃索
//
//  Created by yeetong on 13-8-9.
//  Copyright (c) 2013年 ESSO. All rights reserved.
//

#import "ESSOProductDetailViewController.h"
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"
#import "Global.h"
#import "UIImageView+AFNetworking.h"
#import "StackMenu/PCStackMenu.h"
#import "StackMenu/PCStackMenuItem.h"

@interface ESSOProductDetailViewController ()

@end

@implementation ESSOProductDetailViewController
{
    NSDictionary *detailMainData;
    NSDictionary *detailData;
    int errorLoadCount;
}

@synthesize img1;
@synthesize img1URL;
@synthesize displayPrice;
@synthesize viewBuyMain;
@synthesize viewBuyTop;
@synthesize scrollViewDetail;
@synthesize lblDescription;
@synthesize lblMainPrice;
@synthesize lblTopPrice;
@synthesize viewStandard;
@synthesize mainProductDetailScrollView;
@synthesize mainDescriptionView;

@synthesize PRODUCT_ID;
@synthesize PRODUCT_CATEGORY;
@synthesize PRODUCT_NAME;
@synthesize PRODUCT_TITLE;
@synthesize PRODUCT_IMG1;
@synthesize PRODUCT_PRICE;

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
    viewStandard.hidden = YES;
    self.viewBuyTop.hidden = YES;
    errorLoadCount = 0;
    [self setPage];
    [self LoadPage];
    
    if(errorLoadCount > 0)
    {
        UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"信息"
                                                            message:@"网络不给力啊，请重试."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorView show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.scrollViewDetail.contentOffset.y >= 150) {
        viewBuyTop.hidden = NO;
        viewBuyMain.hidden = YES;
    }else {
        viewBuyTop.hidden = YES;
        viewBuyMain.hidden = NO;
    }
}

-(void)LoadPage
{
    __weak UIImageView *selfImage1 = img1;
    [selfImage1 setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:img1URL]]
                      placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                               success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                   selfImage1.image = image;
                                   
                                   //only required if no placeholder is set to force the imageview on the cell to be laid out to house the new image.
                                   //if(weakCell.imageView.frame.size.height==0 || weakCell.imageView.frame.size.width==0 ){
                                   //                                       [cell setNeedsLayout];
                                   //}
                               }
                               failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                   
                               }];
    self.title = PRODUCT_NAME;
    lblMainPrice.text = displayPrice;
    lblTopPrice.text = displayPrice;
    
    //load product main
    NSMutableDictionary *parametersMain=[[NSMutableDictionary alloc] init];
    [parametersMain setObject:[[NSString alloc]initWithFormat:@"%d",PRODUCT_ID] forKey:@"pId"];
    AFHTTPClient *clientMain = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:[Global GetUrlProduct]]];
    [clientMain registerHTTPOperationClass:[AFJSONRequestOperation class]];
    clientMain.parameterEncoding = AFJSONParameterEncoding;
    [clientMain setDefaultHeader:@"Accept" value:@"application/json"];
    
    [clientMain getPath:@"GetProductById"
         parameters:parametersMain
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                detailMainData = responseObject;
                lblDescription.text = [detailMainData objectForKey:@"PRODUCT_DESC"];
                
                NSMutableDictionary *parameters=[[NSMutableDictionary alloc] init];
                [parameters setObject:[[NSString alloc]initWithFormat:@"%d",PRODUCT_ID] forKey:@"pId"];
                AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:[Global GetUrlProduct]]];
                [client registerHTTPOperationClass:[AFJSONRequestOperation class]];
                client.parameterEncoding = AFJSONParameterEncoding;
                [client setDefaultHeader:@"Accept" value:@"application/json"];
                
                //Load product detail
                [client getPath:@"GetProductDetailById"
                     parameters:parameters
                        success:^(AFHTTPRequestOperation *operation, id responseObject) {
                            detailData = responseObject;
                            if([detailData count] == 1)
                            {
                                viewStandard.hidden = YES;
                                [lblDescription setFrame:CGRectMake(lblDescription.frame.origin.x, lblDescription.frame.origin.y - 190, lblDescription.frame.size.width, lblDescription.frame.size.height)];
                                [lblDescription setTranslatesAutoresizingMaskIntoConstraints:YES];
                                
                                for(NSDictionary *currentJsonData in detailData)
                                {
                                    lblTopPrice.text = [[NSString alloc]initWithFormat:@"￥ %@", [currentJsonData objectForKey:@"PRODUCT_DETAIL_PRICE"]];
                                    lblMainPrice.text = [[NSString alloc]initWithFormat:@"￥ %@", [currentJsonData objectForKey:@"PRODUCT_DETAIL_PRICE"]];
                                }
                            }
                            if([detailData count] > 1)
                            {
                                viewStandard.hidden = NO;
                                for(NSDictionary *currentJsonData in detailData)
                                {
                                }                            
                            }
                        }
                        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                            errorLoadCount = errorLoadCount + 1;
                        }
                 ];
            }
            failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                errorLoadCount = errorLoadCount + 1;
            }
     ];
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
		item.stackTitleLabel.textColor = [UIColor brownColor];
    
	[stackMenu show:^(NSInteger selectedMenuIndex) {
		NSLog(@"menu index : %d", selectedMenuIndex);
	}];
}

@end
