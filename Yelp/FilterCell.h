//
//  FilterCell.h
//  Yelp
//
//  Created by Neal Wu on 2/14/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FilterCell;

@protocol FilterCellDelegate <NSObject>

- (void)filterCell:(FilterCell *)filterCell didChangeValue:(BOOL)value;

@end

@interface FilterCell : UITableViewCell

@property (weak, nonatomic) id<FilterCellDelegate> delegate;
@property (assign, nonatomic) BOOL on;

- (void)setFilterText:(NSString *)text;

@end
