//
//  BaseFetchTableViewController.m
//  WACoreDataSpotlightSample
//
//  Created by Marian Paul on 25/09/2015.
//  Copyright © 2015 Wasappli. All rights reserved.
//

#import "BaseFetchTableViewController.h"
#import <UITableView+NSFetchedResultsController/UITableView+NSFetchedResultsController.h>

@interface BaseFetchTableViewController ()

@end

@implementation BaseFetchTableViewController

- (void)reloadFromAppLinkRefresh {
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sections = [self.fetchResultsController sections];
    id<NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
    
    return [sectionInfo numberOfObjects];
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    [self.tableView addChangeForObjectAtIndexPath:indexPath
                                    forChangeType:type
                                     newIndexPath:newIndexPath];
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type {
    
    [self.tableView addChangeForSection:sectionInfo
                                atIndex:sectionIndex
                          forChangeType:type];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    
    [self.tableView commitChanges];
}

@end
