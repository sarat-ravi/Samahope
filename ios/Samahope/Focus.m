//
//  Focus.m
//  Samahope
//
//  Created by Sarat Tallamraju on 3/8/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import "Focus.h"

@implementation Focus

- (id)initWithDictionary: (NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.thumbnailImageUrlString = dictionary[@"thumbnailImageUrlString"];
        self.focusDescription = dictionary[@"focusDescription"];
    }
    return self;
}

@end
