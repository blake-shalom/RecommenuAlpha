//
//  RMUMenu.m
//  RecommenuAlpha
//
//  Created by Blake Ellingham on 9/25/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import "RMUMenu.h"

@implementation RMUMenu

- (id)initWithString:(NSString*) restaurantName withCourseArray: (NSMutableArray*) courseArray {
    self = [super init];
    if (self) {
        self.restaurantName = restaurantName;
        self.courses = courseArray;
    }
    return self;
}

@end
