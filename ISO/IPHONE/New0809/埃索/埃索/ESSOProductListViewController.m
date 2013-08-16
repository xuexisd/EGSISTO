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

@interface ESSOProductListViewController ()

@end

@implementation ESSOProductListViewController
{
    NSDictionary *listData;
    NSMutableArray *homeTableImg;
    NSMutableArray *homeTableName;
    NSMutableArray *homeTablePrice;
    NSMutableArray *homeTableProductId;
}

@synthesize CategoryName;

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
    self.title = CategoryName;
    [self setPage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
