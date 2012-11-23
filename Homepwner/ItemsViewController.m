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
    return (section == 0) ? [expensiveItems count] : [inexpensiveItems count] ;
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
    
    // not totally sure why, but putting the cell setText outside of the conditional doesn't work
    // throws unused/undeclared variable errors
    if ([indexPath section] == 0) {
        BNRItem *theItem = [expensiveItems objectAtIndex:[indexPath row]];
        [[cell textLabel] setText:[theItem description]] ;
    } else {
        BNRItem *theItem = [inexpensiveItems objectAtIndex:[indexPath row]];
        [[cell textLabel] setText:[theItem description]] ;
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
@end
