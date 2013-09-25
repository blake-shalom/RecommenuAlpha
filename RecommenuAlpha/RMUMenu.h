//
//  RMUMenu.h
//  RecommenuAlpha
//
//  Created by Blake Ellingham on 9/25/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMUMenu : NSObject

@property NSString *restaurantName;
@property NSMutableArray *courses;

- (id)initWithString:(NSString*) restaurantName withCourseArray: (NSMutableArray*) courseArray;

@end