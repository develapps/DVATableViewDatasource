//
//  DVATestCellModelTwo.h
//  DVATableViewDatasource
//
//  Created by Pablo Romeu on 12/5/15.
//  Copyright (c) 2015 Pablo Romeu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DVATableViewCellIdentifierProtocol.h>

@interface DVATestCellModelTwo : NSObject <DVATableViewCellIdentifierProtocol>
@property (nonatomic,strong) NSString*title;

@end
