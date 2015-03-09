//
//  Fund.m
//  Samahope
//
//  Created by Sarat Tallamraju on 3/4/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import "Fund.h"
#import "Doctor.h"

@implementation Fund

- (id)initWithDictionary: (NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.amountRaisedPerTreatment = [dictionary[@"amountRaisedPerTreatment"] floatValue];
        self.amountNeededPerTreatment = [dictionary[@"amountNeededPerTreatment"] floatValue];
        self.numberOfTreatmentsFunded = [dictionary[@"numberOfTreatmentsFunded"] integerValue];
        self.numberOfTreatmentsNeeded = [dictionary[@"numberOfTreatmentsNeeded"] integerValue];
    }
    return self;
}

- (CGFloat)amountPerTreatment {
    return self.amountRaisedPerTreatment + self.amountNeededPerTreatment;
}

@end
