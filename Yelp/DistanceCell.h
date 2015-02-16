//
//  DistanceCell.h
//  Yelp
//
//  Created by Neal Wu on 2/15/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DistanceCell;

@protocol DistanceCellDelegate <NSObject>

- (void)distanceCell:(DistanceCell *)cell didChangeSegment:(NSInteger)segment;

@end

@interface DistanceCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) id<DistanceCellDelegate> delegate;

@end
