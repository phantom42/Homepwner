//
//  DateViewController.h
//  Homepwner
//
//  Created by Joe Coleman on 12/13/12.
//  Copyright (c) 2012 Joe Coleman. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BNRItem ;

@interface DateViewController : UIViewController
{
    __weak IBOutlet UIDatePicker *datePicker ;
}
@property (nonatomic, strong) BNRItem *item ;
@end
