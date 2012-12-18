//
//  BNRItem.h
//  RandomPossessions
//
//  Created by Joe Coleman on 9/4/12.
//  Copyright (c) 2012 Joe Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject

+ (id)randomItem ;

- (id)initWithoutPrice:(NSString *)name
          serialNumber:(NSString *)sNumber ;

- (id)initWithItemName:(NSString *)name
        valueInDollars:(int)value
          serialNumber:(NSString *)sNumber ;

@property (nonatomic, strong) BNRItem *containedItem ;
@property (nonatomic, weak) BNRItem *container ;

@property (nonatomic, copy) NSString *itemName ;
@property (nonatomic, copy) NSString *serialNumber ;
@property (nonatomic) int valueInDollars ;
@property (nonatomic, readonly, strong) NSDate *dateCreated ;

@property (nonatomic, copy) NSString *imageKey ;

@end
