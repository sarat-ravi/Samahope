//
//  BannerView.h
//  Samahope
//
//  Created by Sarat Tallamraju on 3/10/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Doctor.h"

@interface BannerView : UIView

@property (strong, nonatomic) Doctor *doctor;
@property (nonatomic, assign) CGFloat maskAlpha;
@property (nonatomic, assign) CGFloat labelBackgroundAlpha;

@end
