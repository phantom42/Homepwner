//
//  BNRItem.m
//  RandomPossessions
//
//  Created by Joe Coleman on 9/4/12.
//  Copyright (c) 2012 Joe Coleman. All rights reserved.
//

#import "BNRItem.h"

@implementation BNRItem
@synthesize itemName ;
@synthesize containedItem, container, serialNumber, valueInDollars, dateCreated ;
@synthesize imageKey ;


- (id)initWithoutPrice:(NSString *)name serialNumber:(NSString *)sNumber
{
    self = [super init] ;
    if (self) {
        [self setItemName:name] ;
        [self setSerialNumber:sNumber] ;
        dateCreated = [[NSDate alloc] init] ;
    }
    return self ;
}

- (id)initWithItemName:(NSString *)name
        valueInDollars:(int)value
          serialNumber:(NSString *)sNumber
{
    self = [super init] ;
    
    if (self) {
        [self setItemName:name] ;
        [self setSerialNumber:sNumber] ;
        [self setValueInDollars:value] ;
        dateCreated = [[NSDate alloc] init] ;
    }
    return self ;
}
- (id)init
{
    return [self initWithItemName:@"Item"
                   valueInDollars:0
                     serialNumber:@""] ;
}


- (NSString *)description
{
    NSString *descriptionString =
    [[NSString alloc] initWithFormat:@"%@ (%@): Worth $%d, recorded on %@",
     itemName,
     serialNumber,
     valueInDollars,
     dateCreated] ;
    return descriptionString ;
}

+ (id)randomItem
{
    // create an array of 3 adjectives
    NSArray *randomAdjectiveList = [NSArray arrayWithObjects:@"Fluffy",
                                    @"Rusty",
                                    @"Shiny",
                                    nil] ;
    //create an array of three nouns
    NSArray *randomNounList = [NSArray arrayWithObjects:@"Bear",
                               @"Spork",
                               @"Mac",
                               nil] ;
    
    //get index of a random adjective/noun from the lists
    NSInteger adjectiveIndex = rand() % [randomAdjectiveList count] ;
    NSInteger nounIndex = rand() % [randomNounList count] ;
    
    //note that nsInteger is not an object
    NSString *randomName = [NSString stringWithFormat: @"%@ %@",
                            [randomAdjectiveList objectAtIndex:adjectiveIndex],
                            [randomNounList objectAtIndex:nounIndex]] ;
    
    int randomValue = rand() % 100 ;
    
    NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c",
                                    '0' + rand() % 10,
                                    'A' + rand() % 26,
                                    '0' + rand() % 10,
                                    'A' + rand() % 26,
                                    '0' + rand() % 10];
    
    BNRItem *newItem =
    [[self alloc] initWithItemName:randomName
                    valueInDollars:randomValue
                      serialNumber:randomSerialNumber] ;
    
    return newItem ;
}
- (void)setContainedItem:(BNRItem *)i
{
    containedItem = i;
    
    //when given an item to contain, the contained
    // item will be given a pointer to its container
    [i setContainer:self];
}
- (BNRItem *)containedItem
{
    return containedItem ;
}
- (void)setContainer:(BNRItem *)i
{
    container = i ;
}
- (BNRItem *)container
{
    return container ;
}
- (void)dealloc
{
    NSLog(@"Destroyed: %@",self) ;
}


@end
