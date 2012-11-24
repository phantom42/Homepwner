//
//  ItemsViewController.m
//  Homepwner
//
//  Created by Joe Coleman on 11/15/12.
//  Copyright (c) 2012 Joe Coleman. All rights reserved.
//

#import "ItemsViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"

@implementation ItemsViewController

- (id)init
{
    //call the super class initializer
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        for (int i = 0 ; i < 5 ; i++) {
            [[BNRItemStore sharedStore] createItem] ;
        }
    }
    inexpensiveItems = [self getInexpensiveItems];
    expensiveItems = [self getExpensiveItems] ;
    NSLog(@"inexpensive: %@",inexpensiveItems) ;
    return self ;
}
- (id)initWithStyle:(UITableViewStyle)style
{
    return [self init] ;
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return (section == 0) ? [expensiveItems count] + 1 : [inexpensiveItems count] + 1 ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // check for a reusable cell. use that if one exists
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    // if no reusable cell of this type, create a new one
    if (!cell){
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:@"UITableViewCell"];
    }

    if ([indexPath section] == 0) {
        if ([indexPath row] < [expensiveItems count]) {
            BNRItem *theItem = [expensiveItems objectAtIndex:[indexPath row]];
            [[cell textLabel] setFont:[UIFont systemFontOfSize:20]] ;
            [[cell textLabel] setText:[theItem description]] ;
        } else {
            [[cell textLabel] setText:@"No more items!"] ;
        }
        
    } else {
        if ([indexPath row] < [inexpensiveItems count]) {
            BNRItem *theItem = [inexpensiveItems objectAtIndex:[indexPath row]];
            [[cell textLabel] setFont:[UIFont systemFontOfSize:20]] ;
            [[cell textLabel] setText:[theItem description]] ;
        } else {
            [[cell textLabel] setText:@"No more items!"];
        }
        
    }
    
    return cell ;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2 ;
}
- (NSArray *)getInexpensiveItems
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"valueInDollars <= 50"];
    NSArray *items = [[[BNRItemStore sharedStore] allItems] filteredArrayUsingPredicate:predicate];
    return items ;
}
- (NSArray *)getExpensiveItems
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"valueInDollars > 50"];
    NSArray *items = [[[BNRItemStore sharedStore] allItems] filteredArrayUsingPredicate:predicate];
    return items ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height ;
    int numRows ;
    if ([indexPath section] == 0) {
        numRows = [expensiveItems count] ;
    } else {
        numRows = [inexpensiveItems count] ;
    }
    if ([indexPath row] < numRows) {
        height = 60 ;
    } else {
        height = 44 ;
    }
    return height ;
}
- (void)viewDidLoad
{
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tableview.png"]] ;
    [[self tableView] setBackgroundView:backgroundView];
}
@end
