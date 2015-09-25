//
//  CompaniesTableViewController.m
//  WACoreDataSpotlightSample
//
//  Created by Marian Paul on 25/09/2015.
//  Copyright © 2015 Wasappli. All rights reserved.
//

#import "CompaniesTableViewController.h"
#import <MagicalRecord/MagicalRecord.h>
#import "Company.h"

#import "AppLink.h"

@interface CompaniesTableViewController ()
@end

@implementation CompaniesTableViewController

static NSString *CellReuseIdentifier = @"CellReuseIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellReuseIdentifier];
    
    NSFetchedResultsController *fetchedResultsController = [Company MR_fetchAllSortedBy:@"name" ascending:YES withPredicate:nil groupBy:nil delegate:self];
    self.fetchResultsController = fetchedResultsController;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier forIndexPath:indexPath];
    Company *c = [self.fetchResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = c.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Company *c = [self.fetchResultsController objectAtIndexPath:indexPath];

    [AppLink goTo:@"companies/%@", c.name];
}

@end
