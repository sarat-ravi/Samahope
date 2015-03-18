//
//  BannerCell.h
//  Samahope
//
//  Created by Sarat Tallamraju on 3/17/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Doctor.h"

@interface BannerCell : UITableViewCell

@property (nonatomic, strong) Doctor *doctor;
@property (nonatomic, assign) CGFloat maskAlpha;

@end
