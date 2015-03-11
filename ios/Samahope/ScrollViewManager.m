//
//  ScrollViewManager.m
//  Samahope
//
//  Created by Sarat Tallamraju on 3/10/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import "ScrollViewManager.h"

@interface ScrollViewManager()

@property (strong, nonatomic) UIScrollView *scrollView;

@end

@implementation ScrollViewManager

#pragma mark Constructors

- (id)initWithScrollView: (UIScrollView *)scrollView {
    self = [super init];
    if (self) {
        self.scrollView = scrollView;
    }
    return self;
}

#pragma mark Core

- (void)addViewsToScrollView: (NSArray *)views withWidth: (CGFloat)width {
    CGFloat currentHeight = 0;
    for (UIView *view in views) {
        view.frame = CGRectMake(view.frame.origin.x, currentHeight, view.frame.size.width, view.frame.size.height);
        [self.scrollView addSubview: view];
        currentHeight = view.frame.origin.y + view.frame.size.height;
    }
    
    [self.scrollView setContentSize: CGSizeMake(width, currentHeight)];
}

@end
