//
//  RMURatingCell.m
//  RecommenuAlpha
//
//  Created by Blake Ellingham on 10/7/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import "RMURatingCell.h"

@implementation RMURatingCell

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

- (void)loadCurrentMeal:(RMUMeal *)menuMeal
{
    self.currentMeal = menuMeal;
    self.entreeLabel.text = menuMeal.mealName;
    self.numDislikesLabel.text = [NSString stringWithFormat:(@"%i"), menuMeal.mealDislikes];
    self.numLikesLabel.text = [NSString stringWithFormat:(@"%i"), menuMeal.mealLikes];
}

@end
