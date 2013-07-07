//
//  ESSOViewController.m
//  埃索
//
//  Created by yeetong on 13-7-6.
//  Copyright (c) 2013年 ESSO. All rights reserved.
//

#import "ESSOViewController.h"

@interface ESSOViewController ()

@end

@implementation ESSOViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    EScrollerView *scroller=[[EScrollerView alloc] initWithFrameRect:CGRectMake(0, 0, 320, 150)
                                                          ImageArray:[NSArray arrayWithObjects:@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg", nil]
                                                          TitleArray:[NSArray arrayWithObjects:@"11",@"22",@"33",@"44",@"55", nil]];
    scroller.delegate=self;
    [self.view addSubview:scroller];
    
	// Do any additional setup after loading the view, typically from a nib.
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

@end
