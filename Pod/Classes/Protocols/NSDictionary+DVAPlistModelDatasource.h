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

@interface NSDictionary (DVAPlistModelDatasource)
-(instancetype)initWithPlist:(NSString*)plist;
@end
