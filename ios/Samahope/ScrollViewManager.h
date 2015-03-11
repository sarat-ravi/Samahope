//
//  ScrollViewManager.h
//  Samahope
//
//  Created by Sarat Tallamraju on 3/10/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ScrollViewManager : NSObject

- (id)initWithScrollView: (UIScrollView *)scrollView;

- (void)addViewsToScrollView: (NSArray *)views withWidth: (CGFloat)width;

@end
