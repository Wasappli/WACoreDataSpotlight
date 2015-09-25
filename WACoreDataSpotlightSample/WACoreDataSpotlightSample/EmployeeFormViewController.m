//
//  EmployeeFormViewController.m
//  WACoreDataSpotlightSample
//
//  Created by Marian Paul on 25/09/2015.
//  Copyright © 2015 Wasappli. All rights reserved.
//

#import "EmployeeFormViewController.h"
#import "EmployeeForm.h"
#import <MagicalRecord/MagicalRecord.h>
#import "Employee.h"
#import "Company.h"

@interface EmployeeFormViewController ()
@property (nonatomic, strong) Employee *employee;
@end

@implementation EmployeeFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)reloadFromAppLinkRefresh {
    [super reloadFromAppLinkRefresh];
    
    EmployeeForm *form = [EmployeeForm new];
    
    NSString *employeeID = self.appLinkRoutingParameters[@"employeeID"];
    
    if (self.appLinkRoutingParameters[@"employeeID"]) {
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id  _Nonnull evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            return [[(Employee *)evaluatedObject employeeID] isEqualToString:employeeID];
        }];
        Employee *e = [[[Employee MR_findAll] filteredArrayUsingPredicate:predicate] firstObject];
        if (e) {
            self.employee = e;
            
            form.firstName       = e.firstName;
            form.lastName        = e.lastName;
            form.birthDate       = e.birthdate;
            form.jobTitle        = e.jobTitle;
            form.avatarImageName = e.avatarImageName;
        }
    }
    
    self.formController = [[FXFormController alloc] init];
    self.formController.tableView = self.tableView;
    self.formController.delegate = self;
    self.formController.form = form;
    [self.tableView reloadData];
    
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(save)];
    if (self.employee) {
        UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc] initWithTitle:@"Delete"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(delete)];
        self.navigationItem.rightBarButtonItems = @[deleteButton, saveButton];
    }
    else {
        self.navigationItem.rightBarButtonItem = saveButton;
    }
}

- (void)save {
    EmployeeForm *form = (EmployeeForm *)self.formController.form;

    if (self.employee) {
        self.employee.firstName       = form.firstName;
        self.employee.lastName        = form.lastName;
        self.employee.birthdate       = form.birthDate;
        self.employee.jobTitle        = form.jobTitle;
        self.employee.avatarImageName = form.avatarImageName;
        
        [self.employee.managedObjectContext MR_saveOnlySelfAndWait];
    }
    else {
        Employee *e       = [Employee MR_createEntity];
        e.firstName       = form.firstName;
        e.lastName        = form.lastName;
        e.birthdate       = form.birthDate;
        e.jobTitle        = form.jobTitle;
        e.avatarImageName = form.avatarImageName;
        
        Company *currentCompany = [Company MR_findFirstByAttribute:@"name" withValue:self.appLinkRoutingParameters[@"companyName"]];
        e.company = currentCompany;
        
        [e.managedObjectContext MR_saveOnlySelfAndWait];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)delete {
    [self.employee MR_deleteEntity];
    [[NSManagedObjectContext MR_defaultContext] MR_saveOnlySelfAndWait];
    [self dismissViewControllerAnimated:YES completion:nil]; 
}

@end
