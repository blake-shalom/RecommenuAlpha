//
//  RMUMenuTableScreen.m
//  RecommenuAlpha
//
//  Created by Blake Ellingham on 9/30/13.
//  Copyright (c) 2013 Blake Ellingham. All rights reserved.
//

#import "RMUMenuTableScreen.h"

@interface RMUMenuTableScreen ()

@end

@implementation RMUMenuTableScreen

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Datasource methods

/*
 *  Returns number of cells that are in the table
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menu.meals.count;
}

/*
 *  The big kahuna of tableview datasource methods, displays each individual cell
 */

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RMUMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menuCell"];
    if (cell == nil)
        cell = [[RMUMenuCell alloc]initWithStyle:UITableViewCellStyleDefault
                                 reuseIdentifier:@"menuCell"];
    
    RMUMeal *cellMeal = [self.menu.meals objectAtIndex:indexPath.row];
    
    
}
@end
