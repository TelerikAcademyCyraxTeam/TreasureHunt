//
//  CodeDataHelper.h
//  TreasureHunt
//
//  Created by Admin on 11/7/14.
//  Copyright (c) 2014 Cyrax. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CodeDataHelper : NSObject

@property(nonatomic,strong) NSManagedObjectContext* context;
@property(nonatomic, strong) NSManagedObjectModel* model;
@property(nonatomic, strong) NSPersistentStoreCoordinator* coordinator;
@property(nonatomic, strong) NSPersistentStore* store;

- (void)saveContext;
- (void)setupCoreData;

@end
