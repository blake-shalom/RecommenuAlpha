//
//  RMUViewController.m
//  RecommenuAlpha
//
//  Created by Blake Ellingham on 8/14/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import "RMULoginScreen.h"
#import "AFNetworking.h"

#define HEIGHT_OF_KEYBOARD 40.0f
#define TIME_TO_DISPLAY_KEYBOARD 0.3f

@interface RMULoginScreen ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *maleFemaleSeg;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (weak, nonatomic) IBOutlet UIButton *dropDownButton;

@property (strong,nonatomic) User *currentUser;
@end

@implementation RMULoginScreen

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Animation Methods

/*
 *  Slides up the view for the Keyboard
 */

- (void)slideUpView
{
    self.topConstraint.constant -= HEIGHT_OF_KEYBOARD;
    self.bottomConstraint.constant -= HEIGHT_OF_KEYBOARD;
    
    [UIView animateWithDuration:TIME_TO_DISPLAY_KEYBOARD
                     animations:^{
                         [self.view layoutIfNeeded];
                     }];
}

/*
 *  Slides down the view after editing
 */

- (void)slideDownView
{
    self.topConstraint.constant += HEIGHT_OF_KEYBOARD;
    self.bottomConstraint.constant += HEIGHT_OF_KEYBOARD;
    
    [UIView animateWithDuration:TIME_TO_DISPLAY_KEYBOARD
                     animations:^{
                         [self.view layoutIfNeeded];
                     }];
}



#pragma mark - Interactivity

/*
 *  Upon click of large background button, dismiss the keyboard
 */

- (IBAction)dismissKeyboard:(id)sender
{
    [self.view endEditing:YES];
    [self slideDownView];
    [self.dropDownButton setHidden:YES];
    [self.view sendSubviewToBack:self.dropDownButton];

}



#pragma mark - TextField Delegate

/*
 *  Once we begin editing slide up the view
 */

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    // slide up the view
    [self slideUpView];
    [self.dropDownButton setHidden:NO];
    [self.view bringSubviewToFront:self.dropDownButton];
}



- (IBAction)signUpUser:(id)sender
{
    RMUAppDelegate *delegate = (RMUAppDelegate*) [[UIApplication sharedApplication] delegate];
    User *currentUser = (User*) [NSEntityDescription insertNewObjectForEntityForName:@"User"
                                                              inManagedObjectContext:delegate.managedObjectContext];
    
    currentUser.firstName = self.firstNameField.text;
    currentUser.lastName = self.lastNameField.text;
    currentUser.email = self.emailField.text;
    currentUser.city = self.cityTextField.text;
    currentUser.isLoggedIn = NO;
    
    currentUser.maleFemale = [NSNumber numberWithInt:self.maleFemaleSeg.selectedSegmentIndex];
    NSString *gender;
    
    if (currentUser.maleFemale == 0)
        gender = @"male";
    else
        gender = @"female";
    
//    NSError *error;
//    if (![delegate.managedObjectContext save:&error])
//        NSLog(@"Error Saving %@", error);

#warning RecommenuAPI CALL POST USER
    
    NSURL *userURL = [NSURL URLWithString:@"http://recommenu.caisbalderas.com//api/v1/create_user/"];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc]initWithBaseURL:userURL];
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    NSDictionary *user = @{@"username" : currentUser.firstName,
                           @"first_name" : currentUser.firstName,
                           @"last_name" : currentUser.lastName,
                           @"password" : @"poop",
                           @"email" : currentUser.email};
    NSDictionary *params = @{@"city": currentUser.city,
                             @"gender": gender,
                             @"user": user};
    [httpClient postPath:@""
              parameters:params
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                     TODO cache the response vars in some sort of persistent data
                 }
                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     NSLog(@"ERROR DURING POSTUSER: %@ ", error);
                     // TODO do some fail safe
                 }];
    
    [self performSegueWithIdentifier:@"loginToHome" sender:self];
    
}

@end
