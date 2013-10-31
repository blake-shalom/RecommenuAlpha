//
//  RMUHomeScreen.h
//  RecommenuAlpha
//
//  Created by Blake Ellingham on 8/28/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "RMUMenu.h"
#import "RMUMeal.h"
#import "RMUMenuTableScreen.h"
#import "RMUFallbackScreen.h"
#import "RMUButton.h"

@interface RMUHomeScreen : UIViewController
<CLLocationManagerDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet RMUButton *findMenuButton;

+ (RMUMenu*)parseJSONIntoMenu:(NSArray*)JSONArray withRestaurantName:(NSString*)restaurantName;

@end
