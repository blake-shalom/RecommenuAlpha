//
//  RMUMeal.h
//  RecommenuAlpha
//
//  Created by Blake Ellingham on 9/25/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMUMeal : NSObject

@property NSString *mealName;
@property NSString *mealDescription;
@property NSInteger mealLikes;
@property NSInteger mealDislikes;
@property BOOL selected;

- (id)initWithName:(NSString*) name withDescription:(NSString*) description withLikes:(NSInteger) likes withDislikes:(NSInteger) dislikes;

@end
