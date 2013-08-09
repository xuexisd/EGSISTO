//
//  ESSOProductDetailViewController.h
//  埃索
//
//  Created by yeetong on 13-8-9.
//  Copyright (c) 2013年 ESSO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESSOProductDetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *lblProductName;

@property int PRODUCT_ID;
@property NSString *PRODUCT_CATEGORY;
@property NSString *PRODUCT_NAME;
@property NSString *PRODUCT_TITLE;
@property NSString *PRODUCT_IMG1;
@property float PRODUCT_PRICE;

@end
