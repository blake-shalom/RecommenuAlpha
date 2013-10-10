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

@interface RMUHomeScreen : UIViewController
<CLLocationManagerDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *findMenuButton;

@end
