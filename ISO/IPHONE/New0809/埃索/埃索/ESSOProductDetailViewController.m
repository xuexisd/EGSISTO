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

@interface ESSOProductDetailViewController ()

@end

@implementation ESSOProductDetailViewController

@synthesize img1;
@synthesize img1URL;
@synthesize viewBuyMain;
@synthesize viewBuyTop;
@synthesize scrollViewDetail;
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
    self.viewBuyTop.hidden = YES;
	// Do any additional setup after loading the view.
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
    NSLog(@"%@", [[NSString alloc]initWithFormat:@"%d",PRODUCT_ID]);
    NSLog(@"%f",PRODUCT_PRICE);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.scrollViewDetail.contentOffset.y >= 150) {
        viewBuyTop.hidden = NO;
    }else {
        viewBuyTop.hidden = YES;
    }
    
}

@end
