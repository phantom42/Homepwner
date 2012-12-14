//
//  DetailViewController.h
//  Homepwner
//
//  Created by Joe Coleman on 11/28/12.
//  Copyright (c) 2012 Joe Coleman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DateViewController.h"

@class BNRItem ;

@interface DetailViewController : UIViewController
{
    __weak IBOutlet UITextField *nameField;    
    __weak IBOutlet UITextField *serialNumberField;
    __weak IBOutlet UITextField *valueField;
    __weak IBOutlet UILabel *dateLabel;
    
}
@property (nonatomic, strong) BNRItem *item ;
- (IBAction)changeDate:(id)sender ;
@end
