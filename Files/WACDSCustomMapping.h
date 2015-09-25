//
//  WACDSCustomMapping.h
//  WACoreDataSpotlight
//
//  Created by Marian Paul on 21/09/2015.
//  Copyright © 2015 Wasappli. All rights reserved.
//

@import Foundation;
@import CoreSpotlight;

typedef CSSearchableItemAttributeSet* _Nonnull (^WACDSSearchableItemAttributeSetBuilder)(id _Nonnull object);

/**
 This class provides a way to map an NSManagedObject with CSSearchableItem through CSSearchableItemAttributeSet.
 */

@interface WACDSCustomMapping : NSObject

/**
 *  Init the mapping
 *
 *  @param objectClass                       The object class
 *  @param uniqueIdentifierPattern           A pattern for unique identifier. Ex: booking_{#bookingID#}
 *  @param searchableItemAttributeSetBuilder A block which will be called for each object to index. You need to return an attribute set
 *
 *  @return a fresh mapping
 */
- (instancetype _Nonnull)initWithManagedObjectClass:(Class _Nonnull)objectClass
                            uniqueIdentifierPattern:(NSString *_Nonnull)uniqueIdentifierPattern
                  searchableItemAttributeSetBuilder:(WACDSSearchableItemAttributeSetBuilder _Nonnull)searchableItemAttributeSetBuilder;

/**
 *  Get the unique identifier from an object based on the pattern
 *
 *  @param object the object you want to index
 *
 *  @return an unique identifier based on the pattern
 */
- (NSString * _Nonnull)uniqueIdentifierForObject:(id _Nonnull)object;

/**
 *  Get the domain identifier from an object based on the pattern
 *
 *  @param object the object you want to index
 *
 *  @return an domain identifier based on the pattern
 */
- (NSString * _Nonnull)domainIdentifierForObject:(id _Nonnull)object;

/**
 *  Get the searchable item from an object
 *
 *  @param object the object you want to index
 *
 *  @return a spotlight searchable item ready to be added to the index
 */
- (CSSearchableItem * _Nonnull)searchableItemForObject:(id _Nonnull)object;

/**
 *  Get the parameters from a unique identifier you got for example from application:continueUserActivity:restorationHandler:
 *
 *  @param uniqueIdentifier the unique identifier
 *
 *  @return the parameters from the provided pattern
 */
- (NSDictionary * _Nullable)parametersFromUniqueIdentifier:(NSString * _Nonnull)uniqueIdentifier;

@property (nonatomic, strong, readonly, nonnull) Class objectClass;

@property (nonatomic, strong, nullable) NSString *domainIdentifierPattern;
@property (nonatomic, strong, nullable) NSDate   *expirationDate;

@end
