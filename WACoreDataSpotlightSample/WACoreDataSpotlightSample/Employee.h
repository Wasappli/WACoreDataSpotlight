//
//  Employee.h
//  WACoreDataSpotlightSample
//
//  Created by Marian Paul on 22/09/2015.
//  Copyright © 2015 Wasappli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Company;

NS_ASSUME_NONNULL_BEGIN

@interface Employee : NSManagedObject

- (NSString *)employeeID;

@end

NS_ASSUME_NONNULL_END

#import "Employee+CoreDataProperties.h"
