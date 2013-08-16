//
//  ESSOProductListViewController.h
//  埃索
//
//  Created by yeetong on 13-8-15.
//  Copyright (c) 2013年 ESSO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESSOProductListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *listTableView;
@property NSString *CategoryName;
@property int categoryTag;

@end
