//
//  NSDictionary+DVAPlistModelDatasource.h
//  liveAppMockup
//
//  Created by Pablo Romeu on 19/5/15.
//  Copyright (c) 2015 Pablo Romeu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DVATableViewDatasource/NSDictionary+DVATableViewModelDatasource.h>
#import "NSDictionary+DVATableViewModelProtocol.h"

/**
 Implements a datasource based on a plist file.
 */
@interface NSDictionary (DVAPlistModelDatasource)
/**
 @author Pablo Romeu, 15-05-27 09:05:05
 
 Initializes an NSDictionary with a plist creating a valid DVATableViewModelProtocol
 
 @param plist the plist
 
 @return an NSDictionary or nil
 
 @since 1.2.4
 */

-(instancetype)initWithPlist:(NSString*)plist;
@end
