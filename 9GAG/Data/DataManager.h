//
//  DataManager.h
//  9GAG
//
//  Created by Dmytro Skorokhod on 9/13/15.
//  Copyright (c) 2015 Dima Skorokhod. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const HotDataKey = @"hot";
static NSString * const TrendingDataKey = @"trending";
static NSString * const FreshDataKey = @"fresh";

@protocol DataManagerDelegate <NSObject>

- (void)dataRetrieved;

@end

@interface DataManager : NSObject

@property (nonatomic, retain) NSMutableArray *dataEntries;
@property (nonatomic, weak) id<DataManagerDelegate> delegate;

+ (id)sharedManager;

- (void)retrieveData;
- (void)loadMore;

@end
