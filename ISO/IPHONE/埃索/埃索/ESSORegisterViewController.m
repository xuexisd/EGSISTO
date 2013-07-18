//
//  ESSORegisterViewController.m
//  埃索
//
//  Created by yeetong on 13-7-18.
//  Copyright (c) 2013年 ESSO. All rights reserved.
//

#import "ESSORegisterViewController.h"
#import "AFNetworking.h"
#import "Global.h"
#import "FMDatabase.h"

@interface ESSORegisterViewController ()

@property(strong) NSDictionary *userData;

@end

@implementation ESSORegisterViewController
{
    FMDatabase *TryDB;
}
@synthesize txtUserName;
@synthesize txtUserPWD;
@synthesize txtUserPhone;
@synthesize radUserGender;

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

- (IBAction)btnRegister:(id)sender {
    if([txtUserName.text isEqualToString:@""] || [txtUserPWD.text isEqualToString:@""])
    {
        UIAlertView *errorInput = [[UIAlertView alloc] initWithTitle:@"信息"
                                                           message:@"[用户名]和[密码]必须输入."
                                                          delegate:nil
                                                 cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorInput show];
        return;
    }
    
    NSMutableDictionary *parameters=[[NSMutableDictionary alloc] init];
    [parameters setObject:txtUserName.text forKey:@"USER_NAME"];
    [parameters setObject:txtUserPWD.text forKey:@"USER_PWD"];
    [parameters setObject:txtUserPhone.text forKey:@"USER_PHONENUM"];
    if(radUserGender.selectedSegmentIndex == 0)
        [parameters setObject:@"男" forKey:@"USER_GENDER"];
    else
        [parameters setObject:@"女" forKey:@"USER_GENDER"];
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:[Global GetUrlUser]]];
    [client registerHTTPOperationClass:[AFJSONRequestOperation class]];
    client.parameterEncoding = AFJSONParameterEncoding;
    [client setDefaultHeader:@"Accept" value:@"application/json"];
    
    [client postPath:@"RegisterUser"
         parameters:parameters
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                self.userData = responseObject;
                
                //TODO
            }
            failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                UIAlertView *errorReg = [[UIAlertView alloc] initWithTitle:@"信息"
                                                             message:@"网络不给力啊，请重试."
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [errorReg show];
                NSLog(@"%@",[NSString stringWithFormat:@"%@",error]);
            }
     ];

}
@end
