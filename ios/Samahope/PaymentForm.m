//
//  Payment.m
//  Samahope
//
//  Created by Charlie Hu on 3/17/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import "PaymentForm.h"

@interface PaymentForm()

@property (nonatomic, strong) NSDictionary *stateCodes;

@end

@implementation PaymentForm

- (id)init
{
    if ((self = [super init]))
    {
        _expirationYear = 0;
        _expirationMonth = NSNotFound;

        _stateCodes = @{
                         @"AL": @"Alabama",
                         @"AK": @"Alaska",
                         @"AR": @"Arkansas",
                         @"AZ": @"Arizona",
                         @"CA": @"California",
                         @"CO": @"Colorado",
                         @"CT": @"Connecticut",
                         @"DE": @"Delaware",
                         @"FL": @"Florida",
                         @"GA": @"Georgia",
                         @"HI": @"Hawaii",
                         @"ID": @"Idaho",
                         @"IL": @"Illinois",
                         @"IN": @"Indiana",
                         @"IA": @"Iowa",
                         @"KS": @"Kansas",
                         @"KY": @"Kentucky",
                         @"LA": @"Louisiana",
                         @"ME": @"Maine",
                         @"MD": @"Maryland",
                         @"MA": @"Massachusetts",
                         @"MI": @"Michigan",
                         @"MN": @"Minnesota",
                         @"MS": @"Mississippi",
                         @"MO": @"Missouri",
                         @"MT": @"Montana",
                         @"NE": @"Nebraska",
                         @"NV": @"Nevada",
                         @"NH": @"NewHampshire",
                         @"NJ": @"NewJersey",
                         @"NM": @"NewMexico",
                         @"NY": @"NewYork",
                         @"NC": @"NorthCarolina",
                         @"ND": @"NorthDakota",
                         @"OH": @"Ohio",
                         @"OK": @"Oklahoma",
                         @"OR": @"Oregon",
                         @"PA": @"Pennsylvania",
                         @"RI": @"RhodeIsland",
                         @"SC": @"SouthCarolina",
                         @"SD": @"SouthDakota",
                         @"TN": @"Tennessee",
                         @"TX": @"Texas",
                         @"UT": @"Utah",
                         @"VA": @"Virginia",
                         @"VT": @"Vermont",
                         @"WA": @"Washington",
                         @"WV": @"WestVirginia",
                         @"WI": @"Wisconsin",
                         @"WY": @"Wyoming",
                         @"DC": @"DistrictOfColumbia"
                         };

        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [[self class] validationInit];
        });
    }
    return self;
}

- (NSDictionary *)stateField
{


    NSArray *states = self.stateCodes.allKeys;

    return @{FXFormFieldOptions: states, FXFormFieldPlaceholder: @"-", FXFormFieldAction: @"updateFields"};
}

- (NSDictionary *)expirationYearField
{
    NSMutableArray *years = [NSMutableArray array];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    for (NSInteger i = [components year]; i <= 2025 ; i++)
    {
        [years addObject:@(i)];
    }

    return @{FXFormFieldOptions: years, FXFormFieldPlaceholder: @"-", FXFormFieldAction: @"updateFields"};
}

- (NSDictionary *)expirationMonthField
{
    NSArray *months = @[@"January",
                        @"February",
                        @"March",
                        @"April",
                        @"May",
                        @"June",
                        @"July",
                        @"August",
                        @"September",
                        @"October",
                        @"November",
                        @"December"];

    return @{FXFormFieldOptions: months, FXFormFieldPlaceholder: @"-", FXFormFieldAction: @"updateFields"};
}

- (NSArray *)excludedFields
{
    return @[
             @"stateCodes",
             ];
}

-(NSArray *)rules {
    return @[
             // all required fields
             @{
                 FXModelValidatorAttributes : @[@"nameOnCard", @"cardNumber", @"address", @"city", @"state", @"zipCode", @"expirationMonth", @"expirationYear", @"CVN"],
                 FXModelValidatorType : @"required",
                 },
//             // email should be valid email address
//             @{
//                 FXModelValidatorAttributes : @"email",
//                 FXModelValidatorType : @"email",
//                 },

             ];
    
}

@end
