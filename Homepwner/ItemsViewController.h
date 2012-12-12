//
//  ItemsViewController.h
//  Homepwner
//
//  Created by Joe Coleman on 11/15/12.
//  Copyright (c) 2012 Joe Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailViewController.h"

@interface ItemsViewController : UITableViewController
{
    IBOutlet UIView *headerView ;
}
- (UIView *)headerView ;
- (IBAction)addNewItem:(id)sender ;
- (IBAction)toggleEditingMode:(id)sender ;
@end
