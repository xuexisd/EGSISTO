//
//  ESSOLoginViewController.h
//  埃索
//
//  Created by yeetong on 13-7-18.
//  Copyright (c) 2013年 ESSO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESSOLoginViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *txtUserName;
@property (strong, nonatomic) IBOutlet UITextField *txtUserPWD;
- (IBAction)btnLogin:(id)sender;

@end
