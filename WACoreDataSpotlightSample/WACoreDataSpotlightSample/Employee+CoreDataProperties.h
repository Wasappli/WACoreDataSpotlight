//
//  Employee+CoreDataProperties.h
//  WACoreDataSpotlightSample
//
//  Created by Marian Paul on 22/09/2015.
//  Copyright © 2015 Wasappli. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Employee.h"

NS_ASSUME_NONNULL_BEGIN

@interface Employee (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *birthdate;
@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSString *jobTitle;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSString *avatarImageName;
@property (nullable, nonatomic, retain) Company *company;

@end

NS_ASSUME_NONNULL_END
