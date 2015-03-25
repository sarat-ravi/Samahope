//
//  DoctorDetailViewController.h
//  Samahope
//
//  Created by Sarat Tallamraju on 3/4/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Doctor.h"

@interface DoctorDetailViewController : UIViewController

@property (strong, nonatomic) Doctor *doctor;
@property (nonatomic, assign) BOOL hideBannerCell;

@end
