//
//  ESSOViewController.h
//  埃索
//
//  Created by yeetong on 13-8-9.
//  Copyright (c) 2013年 ESSO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JScrollView+PageControl+AutoScroll.h"

@interface ESSOViewController : UIViewController<JScrollViewViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *homeTableView;

@end
