//
//  NSArray+DVAPlistModelDatasource.m
//  liveAppMockup
//
//  Created by Pablo Romeu on 19/5/15.
//  Copyright (c) 2015 Pablo Romeu. All rights reserved.
//

#import "NSArray+DVAPlistModelDatasource.h"

@implementation NSArray (DVAPlistModelDatasource)
-(instancetype)initWithPlist:(NSString*)plist{
    if ([self init]!=nil) {
        NSString* plistPath = [[NSBundle mainBundle] pathForResource:plist ofType:@"plist"];
        self = [NSArray arrayWithContentsOfFile:plistPath];
    }
    return self;
}
@end
