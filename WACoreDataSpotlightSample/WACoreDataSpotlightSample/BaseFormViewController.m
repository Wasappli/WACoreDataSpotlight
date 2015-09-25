//
//  BaseFormViewController.m
//  WACoreDataSpotlightSample
//
//  Created by Marian Paul on 25/09/2015.
//  Copyright © 2015 Wasappli. All rights reserved.
//

#import "BaseFormViewController.h"

@interface BaseFormViewController ()

@end

@implementation BaseFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(dismiss)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)reloadFromAppLinkRefresh {
    
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
