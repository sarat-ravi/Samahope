//
//  Patient.m
//  Samahope
//
//  Created by Sarat Tallamraju on 3/4/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import "Patient.h"

@implementation Patient

- (id)initWithDictionary: (NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"patientName"];
        self.profileImageUrlString = dictionary[@"patientProfileImages"][@"src"];
        self.personalDescription = dictionary[@"patientDescriptions"];
    }
    return self;
}

@end
