//
//  RMURatingCell.h
//  RecommenuAlpha
//
//  Created by Blake Ellingham on 10/7/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMUMeal.h"
#import "AFNetworking.h"

@class RMURatingCell;

@protocol RMURatingCellDelegate <NSObject>

- (void)deleteVideoAtIndex:(NSInteger)index;

@end

@interface RMURatingCell : UITableViewCell

// Enum that describes rating
typedef enum {
    ratingStatusNegative = 0,
    ratingStatusPositive = 1
} ratingStatus;

@property (weak, nonatomic) IBOutlet UILabel *entreeLabel;
@property (weak, nonatomic) IBOutlet UILabel *numDislikesLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLikesLabel;
@property (weak, nonatomic) IBOutlet UIButton *plusButton;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;

@property (weak,nonatomic) RMUMeal *currentMeal;
@property NSInteger index;

@property (weak,nonatomic) id <RMURatingCellDelegate> delegate;

- (void)loadCurrentMeal:(RMUMeal *)menuMeal;

@end
