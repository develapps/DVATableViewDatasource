//
//  DVACustomDatasource.m
//  DVATableViewDatasource
//
//  Created by Pablo Romeu on 13/5/15.
//  Copyright (c) 2015 Pablo Romeu. All rights reserved.
//

#import "DVACustomDatasource.h"
#import <CoreData/CoreData.h>
#import <MagicalRecord/CoreData+MagicalRecord.h>
#import "CellEntity.h"
#import "CellEntityMapper.h"

static NSInteger const numberOfCells=1000;

@interface DVACustomDatasource () <NSFetchedResultsControllerDelegate>
@property (nonatomic,strong) NSFetchedResultsController*fetchedResultsController;
@end

@implementation DVACustomDatasource

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupCoredata];
    }
    return self;
}

-(void)dealloc{
    [MagicalRecord cleanUp];
}

-(void)setupCoredata{
    [MagicalRecord setupCoreDataStack];
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        for (int i=0; i<numberOfCells; i++) {
            CellEntity*newCell=[CellEntity MR_createInContext:localContext];
            newCell.title       =   [NSString stringWithFormat:@"Cell %i",i];
            newCell.subTitle    =   [NSString stringWithFormat:@"Cell SubTitle %i",i];
            newCell.section     =   @(i%50000);
        }
        
    }];}



#pragma mark - FetchedResults

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    _fetchedResultsController = [CellEntity MR_fetchAllGroupedBy:@"section" withPredicate:nil sortedBy:@"title" ascending:YES];
    _fetchedResultsController.delegate=self;
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
