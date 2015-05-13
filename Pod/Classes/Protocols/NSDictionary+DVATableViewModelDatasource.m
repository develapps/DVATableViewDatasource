//
//  NSDictionary+DVAViewModelDatasource.m
//  Pods
//
//  Created by Pablo Romeu on 12/5/15.
//
//

#import "NSDictionary+DVATableViewModelDatasource.h"
#import <objc/runtime.h>


@implementation NSDictionary (DVATableViewModelDatasource)

#pragma mark - Helper

-(NSArray*)viewModelsForSection:(NSInteger)section{
    NSArray*viewModels=[self objectForKey:@(section)];
    return viewModels;
}

#pragma mark - Protocol DVAViewModelDatasource

- (NSInteger)dva_numberOfSectionsInViewModel{
    return [[self allKeys] count];
}
- (NSInteger)dva_numberOfViewModelsInSection:(NSInteger)section{
    NSArray*viewModels=[self viewModelsForSection:section];
    if (viewModels) {
        return [viewModels count];
    }
    return 0;
}
- (id)dva_viewModelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray*viewModels=[self viewModelsForSection:indexPath.section];
    if (viewModels                  &&
        indexPath.row>=0             &&
        indexPath.row<[viewModels count]) {
        return [viewModels objectAtIndex:indexPath.row];
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
