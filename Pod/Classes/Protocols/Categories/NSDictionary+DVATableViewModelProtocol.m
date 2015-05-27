//
//  NSDictionary+DVATableViewModelProtocol.m
//  liveAppMockup
//
//  Created by Pablo Romeu on 19/5/15.
//  Copyright (c) 2015 Pablo Romeu. All rights reserved.
//

#import "NSDictionary+DVATableViewModelProtocol.h"

@implementation NSDictionary (DVATableViewModelProtocol)
-(NSString *)dva_cellIdentifier{
    return [self objectForKey:@"dva_cellIdentifier"];
}
@end
