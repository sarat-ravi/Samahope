//
//  DoctorCell.h
//  Samahope
//
//  Created by Sarat Tallamraju on 3/4/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Doctor.h"
#import "BannerView.h"

@interface DoctorCell : UITableViewCell

@property (nonatomic, strong) Doctor* doctor;
@property (strong, nonatomic) IBOutlet BannerView *bannerView;

@end
