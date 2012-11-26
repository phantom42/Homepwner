//
//  BNRItemStore.m
//  Homepwner
//
//  Created by Joe Coleman on 11/19/12.
//  Copyright (c) 2012 Joe Coleman. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"

@implementation BNRItemStore

- (id)init
{
    self = [super init] ;
    if (self) {
        allItems = [[NSMutableArray alloc] init] ;
    }
    return self ;
}

- (NSArray *)allItems
{
    return allItems ;
}

- (BNRItem *)createItem
{
    BNRItem *p = [BNRItem randomItem] ;
    [allItems addObject:p] ;
    return p ;
}

+ (BNRItemStore *)sharedStore
{
    static BNRItemStore *sharedStore = nil ;
    if (!sharedStore)
        sharedStore = [[super allocWithZone:nil] init] ;
    return sharedStore ;
}
- (void)removeItem:(BNRItem *)p
{
    [allItems removeObjectIdenticalTo:p];
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedStore];
}

@end
