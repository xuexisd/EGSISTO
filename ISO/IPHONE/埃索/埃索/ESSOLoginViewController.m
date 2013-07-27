//
//  ESSOLoginViewController.m
//  埃索
//
//  Created by yeetong on 13-7-18.
//  Copyright (c) 2013年 ESSO. All rights reserved.
//

#import "ESSOLoginViewController.h"
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"
#import "Global.h"
#import "FMDatabase.h"
#import "ESSORegisterViewController.h"


@interface ESSOLoginViewController ()

@property(strong) NSDictionary *LoginData;

@end

@implementation ESSOLoginViewController
{
    FMDatabase *TryDB;
}
@synthesize txtUserName;
@synthesize txtUserPWD;

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
    NSMutableDictionary *parameters=[[NSMutableDictionary alloc] init];
    [parameters setObject:txtUserName.text forKey:@"userName"];
    [parameters setObject:txtUserPWD.text forKey:@"userPWD"];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:[Global GetUrlUser]]];
    [client registerHTTPOperationClass:[AFJSONRequestOperation class]];
    client.parameterEncoding = AFJSONParameterEncoding;
    [client setDefaultHeader:@"Accept" value:@"application/json"];
    
    [client getPath:@"GetUserDetail"
         parameters:parameters
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                self.LoginData = responseObject;
                
                if(responseObject != nil)
                {
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateFormat:@"yyyyMM"];
                    int nowDate = [[formatter stringFromDate: [NSDate date]] intValue];
                    NSString *insertName = txtUserName.text;
                    NSString *insertPWD = [Global EDcaicai:txtUserPWD.text];
                    int insertExpiry = nowDate+3;
                    TryDB=[FMDatabase databaseWithPath:[Global GetLocalDBPath]];
                    if([TryDB open])
                    {
                        [TryDB executeUpdate:@"delete from T_LOGIN"];
                        [TryDB executeUpdate:@"insert into T_LOGIN (LOGIN_NAME, LOGIN_PWD, LOGIN_EXPIRY) values (?,?,?)",insertName,insertPWD,[NSNumber numberWithInt:insertExpiry]];
                    }
                    [TryDB close];
                    
                    [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"ESSOTestGoToViewController"] animated:YES];
                }
                else
                {
                    UIAlertView *errorLogin = [[UIAlertView alloc] initWithTitle:@"信息"
                                              //message:[NSString stringWithFormat:@"%@",error]
                                                                        message:@"用户名或密码错误，请重试."
                                                                       delegate:nil
                                                              cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [errorLogin show];
                }
            }
            failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"信息"
//                                   message:[NSString stringWithFormat:@"%@",error]
                                                             message:@"网络不给力啊，请重试."
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [errorView show];
            }
     ];
}

- (IBAction)btnToRegister:(id)sender {
    ESSORegisterViewController *loginView = [[ESSORegisterViewController alloc]initWithNibName:@"ESSORegisterViewController" bundle:nil];
    [self presentViewController:loginView animated:YES completion:nil];
}
@end
