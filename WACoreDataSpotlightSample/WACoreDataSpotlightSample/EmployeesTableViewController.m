//
//  EmployeesTableViewController.m
//  WACoreDataSpotlightSample
//
//  Created by Marian Paul on 25/09/2015.
//  Copyright © 2015 Wasappli. All rights reserved.
//

#import "EmployeesTableViewController.h"
#import <MagicalRecord/MagicalRecord.h>

#import "Employee.h"
#import "Company.h"

#import "AppLink.h"

@interface EmployeesTableViewController ()

@end

@implementation EmployeesTableViewController

static NSString *CellReuseIdentifier = @"CellReuseIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellReuseIdentifier];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                           target:self
                                                                                           action:@selector(addNewEmployee)];
}

- (void)addNewEmployee {
    [AppLink goTo:@"companies/%@/newEmployee", self.appLinkRoutingParameters[@"companyName"]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier forIndexPath:indexPath];
    Employee *e = [self.fetchResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", e.firstName, e.lastName];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Employee *e = [self.fetchResultsController objectAtIndexPath:indexPath];

    [AppLink goTo:@"companies/%@/%@", e.company.name, e.employeeID];
}

- (void)reloadFromAppLinkRefresh {
    [super reloadFromAppLinkRefresh];
    
    NSFetchedResultsController *fetchedResultsController = [Employee MR_fetchAllSortedBy:@"lastName" ascending:YES withPredicate:[NSPredicate predicateWithFormat:@"company.name == %@", self.appLinkRoutingParameters[@"companyName"]] groupBy:nil delegate:self];
    self.fetchResultsController = fetchedResultsController;
}

@end
