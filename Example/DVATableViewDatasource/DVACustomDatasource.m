//
//  DVACustomDatasource.m
//  DVATableViewDatasource
//
//  Created by Pablo Romeu on 13/5/15.
//  Copyright (c) 2015 Pablo Romeu. All rights reserved.
//

#import "DVACustomDatasource.h"
#import <CoreData/CoreData.h>
#import <MagicalRecord/MagicalRecord.h>
#import "CellEntity.h"
#import "CellEntityMapper.h"


@interface DVACustomDatasource () <NSFetchedResultsControllerDelegate>
@property (nonatomic,strong) NSFetchedResultsController*fetchedResultsController;
@end

@implementation DVACustomDatasource

#pragma mark - FetchedResults

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest*fr=[NSFetchRequest fetchRequestWithEntityName:[CellEntity description]];
    [fr setFetchBatchSize:40];
    [fr setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]]];
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fr managedObjectContext:    [NSManagedObjectContext MR_defaultContext] sectionNameKeyPath:nil cacheName:nil];
    
//    [CellEntity MR_fetchAllGroupedBy:@"section" withPredicate:nil sortedBy:@"title" ascending:YES];
    
    _fetchedResultsController.delegate=self;
    [_fetchedResultsController performFetch:nil];
    return _fetchedResultsController;
}

#pragma mark - Protocol DVAViewModelDatasource

- (NSInteger)dva_numberOfSectionsInViewModel{
    NSInteger sections=[self.fetchedResultsController.sections count];
    return sections;
}
- (NSInteger)dva_numberOfViewModelsInSection:(NSInteger)section{
    if ([[self.fetchedResultsController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
        return [sectionInfo numberOfObjects];
    }
    else
        return 0;
}
- (id)dva_viewModelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellEntity*cellEntity=[self.fetchedResultsController objectAtIndexPath:indexPath];
    return [CellEntityMapper cellEntityMapperWithCellEntity:cellEntity];
}

@end
