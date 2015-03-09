//
//  SamahopeClient.m
//  Samahope
//
//  Created by Sarat Tallamraju on 3/4/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import "SamahopeClient.h"
#import <AFNetworking.h>
#import "Doctor.h"

NSString *const kKimonoLabsKey = @"de529db82ec0c0037a7deedded30878a";

@implementation SamahopeClient

+ (SamahopeClient *)sharedInstance {
    static SamahopeClient *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[SamahopeClient alloc] init];
        }
    });
    
    return instance;
}

- (void)fetchDataWithCompletion:(void (^)(NSArray *doctors, NSError *error))completion {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    
    NSDictionary *parameters = @{@"apikey": kKimonoLabsKey};

    NSMutableArray *doctors = [[NSMutableArray alloc] init];
    
    [manager GET:@"https://www.kimonolabs.com/api/7fu7cppe" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);


        NSCharacterSet* nonDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        
        NSDictionary *results = responseObject[@"results"];
        NSArray *categoryInfos = results[@"categoryInfo"];
        NSArray *doctorInfos = results[@"doctorInfo"];
        NSArray *patientInfos = results[@"patientInfo"];
        NSArray *fundInfos = results[@"fundInfo"];
        
        NSLog(@"lenghts of apis: %ld %ld %ld %ld", [categoryInfos count], [doctorInfos count], [patientInfos count], [fundInfos count]);
        
        for (int i = 0; i < [doctorInfos count]; i++) {
            
            NSDictionary *doctorInfo = doctorInfos[i];
            NSDictionary *patientInfo = patientInfos[i];
            NSDictionary *categoryInfo = categoryInfos[i];
            NSDictionary *fundInfo = fundInfos[i];

            NSLog(@"all info: %@ %@ %@ %@", doctorInfo, patientInfo, categoryInfo, fundInfo);
            
            NSLog(@"fund numbers: %@ %@ %@", [fundInfo[@"amountNeeded"] stringByTrimmingCharactersInSet:nonDigits], [fundInfo[@"treatmentsFunded"] stringByTrimmingCharactersInSet:nonDigits], ([fundInfo[@"peopleDonated"] isKindOfClass:[NSNull class]] || fundInfo[@"peopleDonated"] == nil || fundInfo[@"peopleDonated"] == (id)[NSNull null]) ? 0 : [fundInfo[@"peopleDonated"] stringByTrimmingCharactersInSet:nonDigits]);

//            NSLog(@"doctorInfo: %@", fundInfo);

            NSDictionary *fund = @{
                                   @"amountNeededForCurrentTreatment": [fundInfo[@"amountNeeded"] stringByTrimmingCharactersInSet:nonDigits],
                                   @"amountNeededPerTreatment": @150,
                                   @"numberOfTreatmentsFunded": [fundInfo[@"treatmentsFunded"] stringByTrimmingCharactersInSet:nonDigits],
                                   @"numberOfTreatmentsNeeded": @150,
                                   @"numberOfPeopleDonated": @0
                                   };
            
            NSDictionary *focus = @{
                                    @"name": categoryInfo[@"categoryName"],
                                    @"thumbnailImageUrlString": categoryInfo[@"categoryImage"][@"src"],
                                    @"focusDescription": [categoryInfo[@"categoryDescription"] isKindOfClass:[NSDictionary class]] ?  categoryInfo[@"categoryDescription"][@"text"] : categoryInfo[@"categoryDescription"]
                                    };
            
            NSDictionary *formattedData = @{@"name": doctorInfo[@"name"],
                              @"profileImageUrlString": @"",
                              @"tagLine": @"",
                              @"personalDescription": [doctorInfo[@"description"] isKindOfClass:[NSDictionary class]] ? doctorInfo[@"description"][@"text"] : doctorInfo[@"description"],
                              @"parentOrganization": @"",
                              @"fund": fund,
                              @"focuses": @[ focus ],
                              @"fullScreenImageUrlString": doctorInfo[@"bannerImage"][@"src"],
                              @"quote": @"",
                              @"videoUrlString": @"",
                              @"humanReadableLocation": doctorInfo[@"location"]
                              };
            
            NSLog(@"formatted Data: %@", formattedData);
            
            Doctor *doctor = [[Doctor alloc] initWithDictionary:formattedData];
            
            [doctors addObject:doctor];
        }
        
        completion(doctors, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];

}

@end
