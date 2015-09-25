//
//  BaseFetchTableViewController.h
//  WACoreDataSpotlightSample
//
//  Created by Marian Paul on 25/09/2015.
//  Copyright © 2015 Wasappli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WAAppRouting/WAAppRouting.h>

@import CoreData;

@interface BaseFetchTableViewController : UITableViewController <WAAppRouterTargetControllerProtocol, NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchResultsController;

@end
