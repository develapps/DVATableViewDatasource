//
//  NSArray+DVAViewModelDatasource.m
//  Pods
//
//  Created by Pablo Romeu on 12/5/15.
//
//

#import "NSArray+DVATableViewModelDatasource.h"
#import <objc/runtime.h>

@implementation  NSArray (DVATableViewModelDatasource)

#pragma mark - Protocol DVAViewModelDatasource

- (NSInteger)dva_numberOfSectionsInViewModel{
    return 1;
}
- (NSInteger)dva_numberOfViewModelsInSection:(NSInteger)section{
    return [self count];
}
- (id)dva_viewModelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0        &&
        indexPath.row>=0             &&
        indexPath.row<[self count]) {
        return [self objectAtIndex:indexPath.row];
    }
    return nil;
}

-(id<DVATableViewModelDatasourceDelegate>)delegate{
    return objc_getAssociatedObject(self, @selector(delegate));
}

-(void)setDelegate:(id<DVATableViewModelDatasourceDelegate>)delegate{
    objc_setAssociatedObject(self, @selector(delegate), delegate, OBJC_ASSOCIATION_ASSIGN);
}

@end
