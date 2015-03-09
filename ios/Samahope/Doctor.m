//
//  Doctor.m
//  Samahope
//
//  Created by Sarat Tallamraju on 3/4/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import "Doctor.h"
#import "Patient.h"

@implementation Doctor

- (id)initWithDictionary: (NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        // Code to init from dictionary here.
        self.name = dictionary[@"name"];
        self.profileImageUrlString = dictionary[@"profileImageUrlString"];
        self.tagLine = dictionary[@"tagLine"];
        self.personalDescription = dictionary[@"personalDescription"];
        self.focusDescription = dictionary[@"focusDescription"];
        self.parentOrganization = dictionary[@"parentOrganization"];
        
        self.fund = [[Fund alloc] initWithDoctor: self andDictionary: dictionary[@"fund"]];
        
        self.fullScreenImageUrlString = dictionary[@"fullScreenImageUrlString"];
        self.videoUrlString = dictionary[@"videoUrlString"];
        self.quote = dictionary[@"quote"];
        self.humanReadableLocation = dictionary[@"humanReadableLocation"];
    }
    return self;
}

@end
