//
//  NSArray+DVAViewModelDatasource.m
//  Pods
//
//  Created by Pablo Romeu on 12/5/15.
//
//

#import "NSArray+DVAViewModelDatasource.h"

@implementation  NSArray (DVAViewModelDatasource)


#pragma mark - Protocol DVAViewModelDatasource

- (NSInteger)numberOfSectionsInViewModel{
    return 1;
}
- (NSInteger)numberOfViewModelsInSection:(NSInteger)section{
    return [self count];
}
- (id)viewModelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0        &&
        indexPath.row>=0             &&
        indexPath.row<[self count]) {
        return [self objectAtIndex:indexPath.row];
    }
    return nil;
}
@end
