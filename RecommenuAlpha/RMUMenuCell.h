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

@property (weak, nonatomic) IBOutlet UIButton *checkButton;
@property (weak, nonatomic) IBOutlet UILabel *mealNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mealDescLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dislikeLabel;

- (void)setCurrentMeal:(RMUMeal *)menuMeal;

@end
