//
//  RMUMenuCell.h
//  RecommenuAlpha
//
//  Created by Blake Ellingham on 9/30/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMUMeal.h"

@interface RMUMenuCell : UITableViewCell

// Enum that describes the state of the cell
typedef enum {
    orderStatusStateUnselected,
    orderStatusStateSelected
} orderStatusState;

@property (weak, nonatomic) RMUMeal *currentMeal;
@property (weak, nonatomic) IBOutlet UIButton *checkButton;
@property (weak, nonatomic) IBOutlet UILabel *mealNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mealDescLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dislikeLabel;


@property orderStatusState currentOrderState;
- (void)loadCurrentMeal:(RMUMeal *)menuMeal;

@end
