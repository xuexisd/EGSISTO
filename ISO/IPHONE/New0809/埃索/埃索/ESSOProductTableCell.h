//
//  ESSOProductTableCell.h
//  埃索
//
//  Created by yeetong on 13-8-9.
//  Copyright (c) 2013年 ESSO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESSOProductTableCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblPrice;

@end
