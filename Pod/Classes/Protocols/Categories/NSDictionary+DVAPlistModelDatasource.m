//
//  NSDictionary+DVAPlistModelDatasource.m
//  liveAppMockup
//
//  Created by Pablo Romeu on 19/5/15.
//  Copyright (c) 2015 Pablo Romeu. All rights reserved.
//

#import "NSDictionary+DVAPlistModelDatasource.h"

@implementation NSDictionary (DVAPlistModelDatasource)
-(instancetype)initWithPlist:(NSString*)plist{
    if ([self init]!=nil) {
        NSString* plistPath = [[NSBundle mainBundle] pathForResource:plist ofType:@"plist"];
        self = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    }
    return self;
}

@end
