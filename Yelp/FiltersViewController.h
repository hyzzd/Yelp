//
//  FiltersViewController.h
//  Yelp
//
//  Created by Neal Wu on 2/14/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FiltersViewController;

@protocol FiltersViewControllerDelegate <NSObject>

- (void)filtersViewController:(FiltersViewController *)filtersViewController didChangeFilters:(NSDictionary *)filters;

@end

@interface FiltersViewController : UIViewController

@property (weak, nonatomic) id<FiltersViewControllerDelegate> delegate;

@end
