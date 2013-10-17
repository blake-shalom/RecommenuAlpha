//
//  RMUHomeScreen.m
//  RecommenuAlpha
//
//  Created by Blake Ellingham on 8/28/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#define NUM_FALLBACK 5
#define START_RADIUS 100

#import "RMUHomeScreen.h"

@interface RMUHomeScreen ()

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;
@property (strong, nonatomic) RMUMenu *currentMenu;
@property (strong,nonatomic) NSString *restName;
@property (strong,nonatomic) NSMutableArray *nextFiveRestaurants;

@end

@implementation RMUHomeScreen

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.location = [[CLLocation alloc]init];
    [self.locationManager startUpdatingLocation];
    
    self.nextFiveRestaurants = [[NSMutableArray alloc]initWithCapacity:NUM_FALLBACK];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Location manager delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.location = locations[0];
}


#pragma mark - Interactivity

/*
 *  Locates nearby restaurants
 */

- (IBAction)findRestaurants:(id)sender
{
    
    NSLog(@"LOCATING.....");
    
    CGFloat lat = self.location.coordinate.latitude;
    CGFloat longi = self.location.coordinate.longitude;
    
    NSString *latLongString = [NSString stringWithFormat:(@"%f,%f"), lat, longi];
    NSString *idString = @"YZVWMVDV1AFEHQ5N5DX4KFLCSVPXEC1L0KUQI45NQTF3IPXT"; // TODO save as USERDEFAULTS
    NSString *secretString = @"2GA3BI5S4Z10ONRUJRWA40OTYDED3LAGCUAXJDBBEUNR4JJN";
    NSURL *foursquareURL = [[NSURL alloc]initWithString:[NSString
                                                         stringWithFormat: (@"https://api.foursquare.com/v2/venues/search?ll=%@&limit=15&intent=browse&radius=%i&categoryId=4d4b7105d754a06374d81259&client_id=%@&client_secret=%@&v=20130918"),
                                                         latLongString, 200, idString, secretString]];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:foursquareURL];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation
                                         JSONRequestOperationWithRequest:request
                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                             NSDictionary *newDictionary = [JSON objectForKey:@"response"];
                                             NSArray *newArray = [newDictionary objectForKey:@"venues"];
                                             self.restName = [newArray[0] objectForKey:@"name"];
                                             for (int i = 1; i <= newArray.count; i++) {
                                                 self.nextFiveRestaurants[i-1] = [newArray[i] objectForKey:@"name"];
                                             }
                                             
                                             NSLog(@"%@", self.nextFiveRestaurants);
                                             UIAlertView *restaurantCheckAlert = [[UIAlertView alloc] initWithTitle:@"Restaurant Found!"
                                                                                                            message:[NSString stringWithFormat:(@"Are you at %@?"), self.restName]
                                                                                                           delegate:self
                                                                                                  cancelButtonTitle:@"NO"
                                                                                                  otherButtonTitles:@"YES", nil];
                                             [restaurantCheckAlert show];
                                             
                                         }
                                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                             NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
                                         }];
    [operation start];
    
    
}


/*
 *  Pulls a menu from a given restaurant
 */

- (void)pullMenuFromRestaurant:(NSString*)restaurantName
{
    NSURL *restaurantURL = [NSURL URLWithString:[NSString
                                                 stringWithFormat:(@"http://caisbalderas.webfactional.com/api/dishlist.json")]];
    NSURLRequest *restRequest = [[NSURLRequest alloc]initWithURL:restaurantURL];
    AFJSONRequestOperation *restOperation = [AFJSONRequestOperation
                                             JSONRequestOperationWithRequest:restRequest
                                             success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                 NSArray *mealArray = [JSON objectForKey:@"dishes"];
                                                 RMUMenu *currentMenu = [RMUHomeScreen parseJSONIntoMenu:mealArray
                                                                            withRestaurantName:restaurantName];
                                                 self.currentMenu = currentMenu;
                                                 [self performSegueWithIdentifier:@"homeToMenu" sender:self];
                                             }
                                             failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                 NSLog(@"ERROR: %@", error);
                                             }];
    [self.locationManager stopUpdatingLocation];
    [restOperation start];
    
#warning RecommenuAPI call GET MENU

//    NSURL *menuURL = [NSURL URLWithString:[NSString
//                                           stringWithFormat:(@"http://recommenu.caisbalderas.com//api/v1/restaurants/")]];
//    AFHTTPClient *httpClient = [[AFHTTPClient alloc]initWithBaseURL:menuURL];
//    NSDictionary *params = @{};
//    [httpClient getPath:@""
//             parameters:params
//                success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                    NSArray *mealArray = [responseObject objectForKey:@"dishes"];
//                    RMUMenu *currentMenu = [RMUHomeScreen parseJSONIntoMenu:mealArray
//                                                         withRestaurantName:restaurantName];
//                    self.currentMenu = currentMenu;
//                    [self performSegueWithIdentifier:@"homeToMenu" sender:self];
//                }
//                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                    NSLog(@"ERROR DURING GET MENU: %@", error);
//                }];
}

/*
 *  Processes a given JSON item into a menu object
 */

+ (RMUMenu*)parseJSONIntoMenu:(NSArray*)JSONArray withRestaurantName:(NSString*)restaurantName {
    
    NSMutableArray *currentCourses = [[NSMutableArray alloc]init];
    for (NSDictionary *meal in JSONArray) {
        NSString *mealName = [meal objectForKey:@"name"];
        NSString *mealDesc = [meal objectForKey:@"description"];
        NSString *mealLikes = [meal objectForKey:@"likes"];
        NSInteger numLikes = [mealLikes integerValue];
        NSString *mealDislikes = [meal objectForKey:@"dislikes"];
        NSInteger numDislikes = [mealDislikes integerValue];
        NSString *mealID = [meal objectForKey:@"dsh_key"];
        RMUMeal *currentMeal = [[RMUMeal alloc]initWithName:mealName
                                            withDescription:mealDesc
                                                  withLikes:numLikes
                                               withDislikes:numDislikes
                                             withIdentifier:mealID];
        [currentCourses addObject:currentMeal];
        
    }
    RMUMenu *currentMenu = [[RMUMenu alloc]initWithString:restaurantName withCourseArray:currentCourses];
    return currentMenu;
}

#pragma mark - segue methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier  isEqual: @"homeToMenu"]){
        RMUMenuTableScreen *newMenu = (RMUMenuTableScreen *) segue.destinationViewController;
        [newMenu setMenu:self.currentMenu];
    }
    else if ([segue.identifier isEqual:@"homeToFallback"]) {
        RMUFallbackScreen *newFallback = (RMUFallbackScreen *) segue.destinationViewController;
        newFallback.restaurants = self.nextFiveRestaurants;
    }
    else {
        NSLog(@"Unknown segue");
    }
}

#pragma mark - UIAlertView methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self pullMenuFromRestaurant:self.restName];
    }
    else if (buttonIndex == 0) {
        [self performSegueWithIdentifier:@"homeToFallback" sender:self];
    }
}

@end





