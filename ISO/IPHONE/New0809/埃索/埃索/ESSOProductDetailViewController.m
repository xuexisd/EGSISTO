//
//  ESSOProductDetailViewController.m
//  埃索
//
//  Created by yeetong on 13-8-9.
//  Copyright (c) 2013年 ESSO. All rights reserved.
//

#import "ESSOProductDetailViewController.h"

@interface ESSOProductDetailViewController ()

@end

@implementation ESSOProductDetailViewController

@synthesize lblProductName;
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
    self.title = PRODUCT_NAME;
    lblProductName.text = [[NSString alloc]initWithFormat:@"%d",PRODUCT_ID];
    NSLog(@"%f",PRODUCT_PRICE);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
