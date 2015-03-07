//
//  DonateCell.h
//  Samahope
//
//  Created by Charlie Hu on 3/6/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DonateCell : UITableViewCell

- (void)setDonateAmountText:(NSString *)donateAmountText;
- (void)enableEdit;
- (void)setChecked:(BOOL)checked;

@end
