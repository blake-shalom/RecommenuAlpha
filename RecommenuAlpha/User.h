//
//  User.h
//  RecommenuAlpha
//
//  Created by Blake Ellingham on 8/16/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSNumber * maleFemale;
@property (nonatomic, retain) NSNumber * isLoggedIn;
@property (nonatomic, retain) NSSet *userToRatings;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addUserToRatingsObject:(NSManagedObject *)value;
- (void)removeUserToRatingsObject:(NSManagedObject *)value;
- (void)addUserToRatings:(NSSet *)values;
- (void)removeUserToRatings:(NSSet *)values;

@end
