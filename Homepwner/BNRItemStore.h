//
//  BNRItemStore.h
//  Homepwner
//
//  Created by Joe Coleman on 11/19/12.
//  Copyright (c) 2012 Joe Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNRItem ; // allows declaration without import. ok to do since we are just declaring methods, not implementing

@interface BNRItemStore : NSObject
{
    NSMutableArray *allItems ;
}

//note that this is a class method prefixed with a + instead of a -
+ (BNRItemStore *)sharedStore ;

- (NSArray *)allItems ;
- (BNRItem *)createItem ;
@end
