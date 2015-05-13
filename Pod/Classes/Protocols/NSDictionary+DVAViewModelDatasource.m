//
//  NSDictionary+DVAViewModelDatasource.m
//  Pods
//
//  Created by Pablo Romeu on 12/5/15.
//
//

#import "NSDictionary+DVAViewModelDatasource.h"

@implementation NSDictionary (DVAViewModelDatasource)

#pragma mark - Helper

-(NSArray*)viewModelsForSection:(NSInteger)section{
    NSArray*viewModels=[self objectForKey:@(section)];
    return viewModels;
}

#pragma mark - Protocol DVAViewModelDatasource

- (NSInteger)numberOfSectionsInViewModel{
    return [[self allKeys] count];
}
- (NSInteger)numberOfViewModelsInSection:(NSInteger)section{
    NSArray*viewModels=[self viewModelsForSection:section];
    if (viewModels) {
        return [viewModels count];
    }
    return 0;
}
- (id)viewModelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray*viewModels=[self viewModelsForSection:indexPath.section];
    if (viewModels                  &&
        indexPath.row>=0             &&
        indexPath.row<[viewModels count]) {
        return [viewModels objectAtIndex:indexPath.row];
    }
    return nil;
}
@end
