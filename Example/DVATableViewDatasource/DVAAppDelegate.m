//
//  DVAAppDelegate.m
//  DVATableViewDatasource
//
//  Created by CocoaPods on 04/07/2015.
//  Copyright (c) 2014 Pablo Romeu. All rights reserved.
//

#import "DVAAppDelegate.h"
#import <MagicalRecord/MagicalRecord.h>
#import "CellEntity.h"
static NSInteger const numberOfCells=10000;

@implementation DVAAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self cleanAndResetupDB];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
     [MagicalRecord cleanUp];
}



-(void)setupCoredata{
    [MagicalRecord setupCoreDataStack];
    for (int j=0; j<10; j++) {
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            if ([[CellEntity MR_findAllInContext:localContext] count]) {
                return ;
            }
            for (int i=0; i<numberOfCells/10; i++) {
                CellEntity*newCell=[CellEntity MR_createEntityInContext:localContext];
                newCell.title       =   [NSString stringWithFormat:@"Cell %i",i];
                newCell.subTitle    =   [NSString stringWithFormat:@"Cell SubTitle %i",i];
                newCell.section     =   @(i%(numberOfCells/2));
            }
            
        } completion:^(BOOL success, NSError *error) {
            [[NSManagedObjectContext MR_defaultContext] reset];
        }];
    }
}


#pragma mark - clean Core Data DB
- (void)cleanAndResetupDB {
    [MagicalRecord cleanUp];
    
    NSString *dbStore = [MagicalRecord defaultStoreName];
    
    NSURL *storeURL = [NSPersistentStore MR_urlForStoreName:dbStore];
    NSURL *walURL = [[storeURL URLByDeletingPathExtension] URLByAppendingPathExtension:@"sqlite-wal"];
    NSURL *shmURL = [[storeURL URLByDeletingPathExtension] URLByAppendingPathExtension:@"sqlite-shm"];
    
    NSError *error = nil;
    BOOL result = YES;
    
    for (NSURL *url in @[storeURL, walURL, shmURL]) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:url.path]) {
            result = [[NSFileManager defaultManager] removeItemAtURL:url error:&error];
        }
    }
    
    if (result) {
        [self setupCoredata];
    } else {
        NSLog(@"An error has occurred while deleting %@ error %@", dbStore, error);
    }
}



@end
