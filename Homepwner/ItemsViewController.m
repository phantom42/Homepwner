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
        UINavigationItem *n = [self navigationItem] ;
        
        [n setTitle:@"Homepwner"] ;
        
        // create a new bar button item that will send
        // addNewItem: to ItemsViewController
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc]
                                initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                target:self
                                action:@selector(addNewItem:)] ;
        //set this bar button item as the right item in the navigationItem
        [[self navigationItem] setRightBarButtonItem:bbi] ;
        
        [[self navigationItem] setLeftBarButtonItem:[self editButtonItem]] ;
    }
    return self ;
}
- (id)initWithStyle:(UITableViewStyle)style
{
    return [self init] ;
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [[[BNRItemStore sharedStore] allItems] count] ;
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
    
    // set the text on the cell with the description of the item
    // that is at the nth index of items, where n = row this cell
    // will appear in on the tableview
    BNRItem *p = [[[BNRItemStore sharedStore] allItems] objectAtIndex:[indexPath row]];
    
    [[cell textLabel] setText:[p description]] ;
    
    return cell ;
}
- (IBAction)addNewItem:(id)sender
{
    // create a new BNRItem and add it to the store
    BNRItem *newItem = [[BNRItemStore sharedStore] createItem] ;
    int lastRow = [[[BNRItemStore sharedStore] allItems] indexOfObject:newItem] ;
    
    NSIndexPath *ip = [NSIndexPath indexPathForRow:lastRow inSection:0] ;
    
    // insert this new row into the table
    [[self tableView] insertRowsAtIndexPaths:[NSArray arrayWithObject:ip]
                            withRowAnimation:UITableViewRowAnimationTop] ;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // if the table view is asking to commit a delete...
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        BNRItemStore *ps = [BNRItemStore sharedStore] ;
        NSArray *items = [ps allItems] ;
        BNRItem *p = [items objectAtIndex:[indexPath row]] ;
        [ps removeItem:p] ;
        
        // also remove that row from the table view with an animation
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationFade] ;
    }
}
- (void)tableView:(UITableView *)tableView
    moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
            toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[BNRItemStore sharedStore] moveItemAtIndex:[sourceIndexPath row]
                                        toIndex:[destinationIndexPath row]] ;
}
-(void)tableView:(UITableView *)aTableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detailViewController = [[DetailViewController alloc] init] ;
    
    NSArray *items = [[BNRItemStore sharedStore] allItems] ;
    BNRItem *selectedItem = [items objectAtIndex:[indexPath row]] ;
    
    //give detail view contoller a pointer to the item object in row
    [detailViewController setItem:selectedItem] ;
    
    //push it to the top of the navigation controllers stack
    [[self navigationController] pushViewController:detailViewController
                                           animated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated] ;
    [[self tableView] reloadData] ;
}
@end
