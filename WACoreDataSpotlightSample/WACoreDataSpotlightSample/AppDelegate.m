//
//  AppDelegate.m
//  WACoreDataSpotlightSample
//
//  Created by Marian Paul on 21/09/2015.
//  Copyright © 2015 Wasappli. All rights reserved.
//

#import "AppDelegate.h"

#import <WACoreDataSpotlight/WACoreDataSpotlight.h>

#import <MagicalRecord/MagicalRecord.h>
#import <WAAppRouting/WAAppRouting.h>

#import "CompaniesTableViewController.h"

#import "Employee.h"
#import "Company.h"

#import "AppLink.h"

@import MobileCoreServices;

@interface AppDelegate ()

@property (nonatomic, strong) WACDSIndexer *mainIndexer;
@property (nonatomic, strong) WAAppRouter *router;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Setup CoreData
    [MagicalRecord setupCoreDataStack];
    
//    [Employee MR_truncateAll];
//    [Company MR_truncateAll];
    
    self.mainIndexer = [[WACDSIndexer alloc] initWithManagedObjectContext:[NSManagedObjectContext MR_defaultContext]];
    
    WACDSSimpleMapping *employeeSearchMapping = [[WACDSSimpleMapping alloc] initWithManagedObjectEntityName:@"Employee"
                                                                                    uniqueIdentifierPattern:@"employee_{#firstName#}_{#lastName#}"
                                                                                               titlePattern:@"{#firstName#} {#lastName#}"
                                                                                  contentDescriptionPattern:@"{#firstName#} {#lastName#} is working as {#jobTitle#} on {#company.name#}"
                                                                                           keywordsPatterns:@[@"employee", @"{#firstName#}", @"{#lastName#}"]
                                                                                       thumbnailDataBuilder:^NSData *(Employee *employee) {
                                                                                           return UIImagePNGRepresentation([UIImage imageNamed:employee.avatarImageName]);
                                                                                       }];
    [self.mainIndexer registerMapping:employeeSearchMapping];
    
    WACDSCustomMapping *companyMapping = [[WACDSCustomMapping alloc] initWithManagedObjectEntityName:@"Company"
                                                                        uniqueIdentifierPattern:@"company_{#name#}"
                                                                   searchableItemAttributeSetBuilder:^CSSearchableItemAttributeSet *(Company *company) {
                                                                       CSSearchableItemAttributeSet *attributeSet = [[CSSearchableItemAttributeSet alloc] initWithItemContentType:(NSString *)kUTTypeText];
                                                                       attributeSet.title                         = company.name;
                                                                       attributeSet.contentDescription            = [NSString stringWithFormat:@"The company has its offices in %@ and its primary activity is %@.\n%ld employees", company.address, company.activity, [company.employees count]];
                                                                       attributeSet.keywords                      = @[@"company", company.name, company.activity];
                                                                       
                                                                       return attributeSet;
                                                                   }];
    [self.mainIndexer registerMapping:companyMapping];
    
    Company *wasappli = [Company MR_findFirstByAttribute:@"name" withValue:@"Wasappli"];
    if (!wasappli) {
        wasappli          = [Company MR_createEntity];
        wasappli.name     = @"Wasappli";
        wasappli.address  = @"A nice place in Montreal";
        wasappli.activity = @"Mobile development";
    }
    
    NSArray *employees = [Employee MR_findAll];
    if ([employees count] == 0) {
        Employee *employee       = [Employee MR_createEntity];
        employee.firstName       = @"Marian";
        employee.lastName        = @"Paul";
        employee.birthdate       = [NSDate date];
        employee.jobTitle        = @"CTO";
        employee.avatarImageName = @"large_1025979";
        employee.company         = wasappli;

        employee                 = [Employee MR_createEntity];
        employee.firstName       = @"Jérémy";
        employee.lastName        = @"Lagrue";
        employee.birthdate       = [NSDate date];
        employee.jobTitle        = @"CEO";
        employee.avatarImageName = @"hires_1025456";
        employee.company         = wasappli;

        employee                 = [Employee MR_createEntity];
        employee.firstName       = @"Arnaud";
        employee.lastName        = @"Lays";
        employee.birthdate       = [NSDate date];
        employee.jobTitle        = @"iOS Developer";
        employee.avatarImageName = @"arnaud_avatar";
        employee.company         = wasappli;

        employee                 = [Employee MR_createEntity];
        employee.firstName       = @"Lisa-Roxane";
        employee.lastName        = @"Lion";
        employee.birthdate       = [NSDate date];
        employee.jobTitle        = @"Graphiste";
        employee.avatarImageName = @"lisa-1";
        employee.company         = wasappli;
    }
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveOnlySelfAndWait];
    
    // UI
    UIWindow *window               = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UINavigationController *nav    = [[UINavigationController alloc] init];
    self.window                    = window;
    self.window.rootViewController = nav;

    // Router
    self.router = [WAAppRouter defaultRouter];
    [self.router.registrar registerAppRoutePath:@"companies{CompaniesTableViewController}/:companyName{EmployeesTableViewController}/newEmployee{EmployeeFormViewController}!" presentingController:nav];
    [self.router.registrar registerAppRoutePath:@"companies{CompaniesTableViewController}/:companyName{EmployeesTableViewController}/:employeeID{EmployeeFormViewController}!" presentingController:nav];

    [AppLink goTo:@"companies"];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler {
    
    
    NSManagedObject *object = [self.mainIndexer objectFromUserActivity:userActivity];
    
    if ([object isKindOfClass:[Company class]]) {
        [AppLink goTo:@"companies/%@", ((Company *)object).name];
    }
    
    if ([object isKindOfClass:[Employee class]]) {
        [AppLink goTo:@"companies/%@/%@", ((Employee *)object).company.name, ((Employee *)object).employeeID];
    }
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [self.router handleURL:url];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [MagicalRecord cleanUp];
}

@end
