//
//  Company+CoreDataProperties.h
//  WACoreDataSpotlightSample
//
//  Created by Marian Paul on 22/09/2015.
//  Copyright © 2015 Wasappli. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Company.h"

NS_ASSUME_NONNULL_BEGIN

@interface Company (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *activity;
@property (nullable, nonatomic, retain) NSString *address;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Employee *> *employees;

@end

@interface Company (CoreDataGeneratedAccessors)

- (void)addEmployeesObject:(Employee *)value;
- (void)removeEmployeesObject:(Employee *)value;
- (void)addEmployees:(NSSet<Employee *> *)values;
- (void)removeEmployees:(NSSet<Employee *> *)values;

@end

NS_ASSUME_NONNULL_END
