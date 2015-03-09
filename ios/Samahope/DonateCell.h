//
//  DonateCell.h
//  Samahope
//
//  Created by Charlie Hu on 3/6/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DonateCell;

@protocol DonateCellDelegate <NSObject>

- (void)donateCell:(DonateCell *)cell didUpdateValue:(NSString *)value;

@end

@interface DonateCell : UITableViewCell

@property (nonatomic, weak) id<DonateCellDelegate> delegate;

- (void)setDonateAmountText:(NSString *)donateAmountText;
- (void)enableEdit;
- (void)setChecked:(BOOL)checked;

@end
