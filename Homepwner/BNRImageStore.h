//
//  BNRImageStore.h
//  Homepwner
//
//  Created by Joe Coleman on 12/17/12.
//  Copyright (c) 2012 Joe Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRImageStore : NSObject
{
    NSMutableDictionary *dictionary ;
}
+ (BNRImageStore *)sharedStore ;

- (void)setImage:(UIImage *)i forKey:(NSString *)s ;
- (UIImage *)imageForKey:(NSString *)s ;
- (void)deleteImageForKey:(NSString *)s ;
@end
