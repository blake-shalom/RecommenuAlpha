//
//  RMUOrderRatingScreen.h
//  RecommenuAlpha
//
//  Created by Blake Ellingham on 10/7/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMURatingCell.h"
#import "RMUMeal.h"

@interface RMUOrderRatingScreen : UIViewController
<UITableViewDataSource, UITableViewDelegate, RMURatingCellDelegate>

@property NSMutableArray *orderedMeals;

@end
