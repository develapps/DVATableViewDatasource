//
//  NSArray+DVAPlistModelDatasource.h
//  liveAppMockup
//
//  Created by Pablo Romeu on 19/5/15.
//  Copyright (c) 2015 Pablo Romeu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DVATableViewDatasource/NSArray+DVATableViewModelDatasource.h>
#import "NSArray+DVAPlistModelDatasource.h"

/**
 Implements a datasource based on a plist file.
 */
@interface NSArray (DVAPlistModelDatasource)
/**
 @author Pablo Romeu, 15-05-27 09:05:05
 
 Initializes an NSArray with a plist creating a valid DVATableViewModelProtocol
 
 @param plist the plist
 
 @return an NSArray or nil
 
 @since 1.2.4
 */
-(instancetype)initWithPlist:(NSString*)plist;
@end
