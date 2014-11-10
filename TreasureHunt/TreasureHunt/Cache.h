//
//  Cache.h
//  TreasureHunt
//
//  Created by Admin on 11/7/14.
//  Copyright (c) 2014 Cyrax. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Cache : NSManagedObject

@property (nonatomic, retain) NSString * cacheId;
@property (nonatomic, retain) NSString * cacheDescription;
@property (nonatomic, retain) NSString * hint;
@property (nonatomic, retain) NSNumber * isFound;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * userFoundIt;
@property (nonatomic, retain) NSString * userCreated;
@property (nonatomic, retain) NSString * place;
@property (nonatomic, retain) NSString * dateCreated;

@end
