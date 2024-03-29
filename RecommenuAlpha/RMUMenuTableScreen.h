//
//  RMUMenuTableScreen.h
//  RecommenuAlpha
//
//  Created by Blake Ellingham on 9/30/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMUMenu.h"
#import "RMUMenuCell.h"
#import "RMUMeal.h"
#import "RMUOrderRatingScreen.h"


@interface RMUMenuTableScreen : UIViewController
<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameOfRestaurant;
- (void)setMenu:(RMUMenu *)menu;
@end