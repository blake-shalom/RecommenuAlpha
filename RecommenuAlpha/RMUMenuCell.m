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
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCurrentMeal:(RMUMeal *)menuMeal
{
    self.mealNameLabel.text = menuMeal.mealName;
    self.mealDescLabel.text = menuMeal.mealDescription;
    self.likeLabel.text = [NSString stringWithFormat:(@"%i"), menuMeal.mealLikes];
    self.dislikeLabel.text = [NSString stringWithFormat:(@"%i"), menuMeal.mealDislikes];

    
}

@end
