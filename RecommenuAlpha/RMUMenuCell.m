//
//  RMUMenuCell.m
//  RecommenuAlpha
//
//  Created by Blake Ellingham on 9/30/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import "RMUMenuCell.h"

@implementation RMUMenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.currentOrderState = orderStatusStateUnselected;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadCurrentMeal:(RMUMeal *)menuMeal
{
    self.currentMeal = menuMeal;
    self.mealNameLabel.text = menuMeal.mealName;
    self.mealDescLabel.text = menuMeal.mealDescription;
    self.likeLabel.text = [NSString stringWithFormat:(@"%i"), menuMeal.mealLikes];
    self.dislikeLabel.text = [NSString stringWithFormat:(@"%i"), menuMeal.mealDislikes];
    if (menuMeal.selected) {
//        [self.checkButton setTitle:@"1" forState:UIControlStateNormal];
        self.currentOrderState = orderStatusStateSelected;
    }
    else {
//        [self.checkButton setTitle:@"0" forState:UIControlStateNormal];
        self.currentOrderState = orderStatusStateUnselected;
    }
}

- (IBAction)selectOrderState:(id)sender
{
    if (self.currentOrderState == orderStatusStateSelected) {
        self.currentOrderState = orderStatusStateUnselected;
        [self.checkButton setBackgroundColor:[UIColor clearColor]];
        [self setAlpha:1.0f];
        self.currentMeal.selected = NO;
    }
    else {
        self.currentOrderState = orderStatusStateSelected;
        [self.checkButton setBackgroundColor:[UIColor RMUGreyToolbarColor]];
        [self.checkButton setAlpha:0.1f];
        self.currentMeal.selected = YES;
    }
}
@end
