//
//  DataManager.h
//  9GAG
//
//  Created by Dmytro Skorokhod on 9/13/15.
//  Copyright (c) 2015 Dima Skorokhod. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const kHotDataKey = @"hot";
static NSString * const kTrendingDataKey = @"trending";
static NSString * const kFreshDataKey = @"fresh";
static NSString * const kAdDataKey = @"ad";

@protocol DataManagerDelegate <NSObject>

- (void)dataRetrieved;

@end

@interface DataManager : NSObject

@property (nonatomic, retain) NSDictionary *dataCollections;
@property (nonatomic, weak) id<DataManagerDelegate> delegate;

+ (id)sharedManager;
+ (NSArray *)dataKeys;

- (void)retrieveDataForKey:(NSString *)key;
- (void)loadMoreForKey:(NSString *)key;
- (NSArray *)entriesForKey:(NSString *)key;

@end
