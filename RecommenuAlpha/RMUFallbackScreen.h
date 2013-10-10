//
//  RMUFallbackScreen.h
//  RecommenuAlpha
//
//  Created by Blake Ellingham on 10/9/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMUOrderRatingScreen.h"
#import "RMUMenu.h"
#import "RMUHomeScreen.h"

@interface RMUFallbackScreen : UIViewController
<UITableViewDataSource, UITableViewDelegate>

@property NSMutableArray *restaurants;

@end
