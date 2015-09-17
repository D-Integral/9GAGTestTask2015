//
//  DataManager.m
//  9GAG
//
//  Created by Dmytro Skorokhod on 9/13/15.
//  Copyright (c) 2015 Dima Skorokhod. All rights reserved.
//

#import "DataManager.h"

#import <AFNetworking.h>
#import "DataEntry.h"
#import "DataCollection.h"

static NSString * const BaseURLString = @"http://dm.arcana.com.ua/";

@interface DataManager () <DataCollectionDelegate>

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger loadingPage;

@end

@implementation DataManager

+ (id)sharedManager {
	static DataManager *sharedManager = nil;
	static dispatch_once_t onceToken;
	
	dispatch_once(&onceToken, ^{
		sharedManager = [[self alloc] init];
		NSMutableDictionary *dataCollections = [NSMutableDictionary dictionary];
		
		for (NSString *dataKey in [self dataKeys]) {
			DataCollection *collection = [DataCollection collectionWithKey:dataKey
																  delegate:sharedManager];
			[dataCollections setValue:collection forKey:dataKey];
		}
		
		sharedManager.dataCollections = dataCollections;
	});
	
	return sharedManager;
}

+ (NSArray *)dataKeys {
	return @[kHotDataKey, kTrendingDataKey, kFreshDataKey, kAdDataKey];
}

- (void)retrieveDataForKey:(NSString *)key
{
	DataCollection *collection = self.dataCollections[key];
	[collection retrieveData];
}

- (void)loadMoreForKey:(NSString *)key {
	DataCollection *collection = self.dataCollections[key];
	[collection loadMore];
}

- (void)dataRetrievedForCollection:(DataCollection *)collection {
	[self.delegate dataRetrieved];
}

- (NSArray *)entriesForKey:(NSString *)key {
	DataCollection *collection = self.dataCollections[key];
	
	return collection.entries;
}

@end
