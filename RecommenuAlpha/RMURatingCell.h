//
//  RMURatingCell.h
//  RecommenuAlpha
//
//  Created by Blake Ellingham on 10/7/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMUMeal.h"

@interface RMURatingCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *entreeLabel;
@property (weak, nonatomic) IBOutlet UILabel *numDislikesLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLikesLabel;

@property (weak,nonatomic) RMUMeal *currentMeal;

- (void)loadCurrentMeal:(RMUMeal *)menuMeal;

@end
