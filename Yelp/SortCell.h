//
//  SegmentedCell.h
//  Yelp
//
//  Created by Neal Wu on 2/15/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SortCell;

@protocol SortCellDelegate <NSObject>

- (void)sortCell:(SortCell *)sortCell didChangeSegment:(NSInteger)segment;

@end

@interface SortCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) id<SortCellDelegate> delegate;

@end
