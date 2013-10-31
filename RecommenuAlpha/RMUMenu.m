//
//  RMUMenu.m
//  RecommenuAlpha
//
//  Created by Blake Ellingham on 9/25/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import "RMUMenu.h"

@implementation RMUMenu

- (id)initWithString:(NSString*) restaurantName withAddress:(NSString*) address
{
    self = [super init];
    if (self) {
        self.restaurantName = restaurantName;
        self.restaurantAddress = address;
    }
    return self;
}

- (id)initWithString:(NSString *)restaurantName withCourseArray:(NSMutableArray *)mealArray
{
    self = [super init];
    if (self) {
        self.restaurantName = restaurantName;
        self.meals = mealArray;
    }
    return self;
}

@end
