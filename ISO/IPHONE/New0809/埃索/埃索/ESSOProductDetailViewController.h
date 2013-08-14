//
//  ESSOProductDetailViewController.h
//  埃索
//
//  Created by yeetong on 13-8-9.
//  Copyright (c) 2013年 ESSO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESSOProductDetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *img1;
@property NSString *img1URL;
@property NSString *displayPrice;
@property (strong, nonatomic) IBOutlet UIView *viewBuyTop;
@property (strong, nonatomic) IBOutlet UIView *viewBuyMain;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollViewDetail;
@property (strong, nonatomic) IBOutlet UILabel *lblDescription;
@property (strong, nonatomic) IBOutlet UILabel *lblMainPrice;
@property (strong, nonatomic) IBOutlet UILabel *lblTopPrice;
@property (strong, nonatomic) IBOutlet UIView *viewStandard;
@property (strong, nonatomic) IBOutlet UIButton *btnStandSuper;
@property (strong, nonatomic) IBOutlet UIButton *btnStandLittle;
@property (strong, nonatomic) IBOutlet UIButton *btnStandMiddle;
@property (strong, nonatomic) IBOutlet UIButton *btnStandHot;
@property (strong, nonatomic) IBOutlet UIButton *btnStandCold;
- (IBAction)SizePressed:(id)sender;
- (IBAction)HotColdPressed:(id)sender;

@property int PRODUCT_ID;
@property NSString *PRODUCT_CATEGORY;
@property NSString *PRODUCT_NAME;
@property NSString *PRODUCT_TITLE;
@property NSString *PRODUCT_IMG1;
@property float PRODUCT_PRICE;

@end
