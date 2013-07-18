//
//  ESSOTestGoToViewController.m
//  埃索
//
//  Created by yeetong on 13-7-18.
//  Copyright (c) 2013年 ESSO. All rights reserved.
//

#import "ESSOTestGoToViewController.h"
#import "Global.h"

@interface ESSOTestGoToViewController ()

@end

@implementation ESSOTestGoToViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnLogin:(id)sender {
    // 获取故事板
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    UIViewController *next;
    
    if ([[Global IsLogin] isEqualToString:@"0"]) {
        // login
        next = [board instantiateViewControllerWithIdentifier:@"ESSOLoginViewController"];
    }
    else{
        //Personal Center
        next = [board instantiateViewControllerWithIdentifier:@"ESSOPersonalCenterViewController"];
    }
    
    // 跳转
    [self.navigationController pushViewController:next animated:YES];
}
@end
