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

static NSString * const BaseURLString = @"http://dm.arcana.com.ua/";

@interface DataManager ()

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger loadingPage;

@end

@implementation DataManager

+ (id)sharedManager {
	static DataManager *sharedManager = nil;
	static dispatch_once_t onceToken;
	
	dispatch_once(&onceToken, ^{
		sharedManager = [[self alloc] init];
		NSMutableDictionary *dataEntries = [NSMutableDictionary dictionary];
		
		for (NSString *dataKey in [self dataKeys]) {
			[dataEntries setValue:[NSMutableArray array] forKey:dataKey];
		}
		
		sharedManager.dataEntries = dataEntries;
		sharedManager.currentPage = -1;
		sharedManager.loadingPage = 1;
	});
	
	return sharedManager;
}

+ (NSArray *)dataKeys {
	return @[HotDataKey, TrendingDataKey, FreshDataKey, AdDataKey];
}

- (void)retrieveData
{
	NSURL *url = [NSURL URLWithString:[self allDataPath]];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	
	AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
	operation.responseSerializer = [AFJSONResponseSerializer serializer];
	
	[operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
		[self setupDataWithResponseArray:(NSArray *)responseObject];
		self.currentPage = self.loadingPage;
		[self.delegate dataRetrieved];
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		NSLog(@"Error Retrieving Data: %@", [error localizedDescription]);
	}];
	
	[operation start];
}

- (NSString *)allDataPath {
	return [NSString stringWithFormat:@"%@api/image/?limit=10&page=%ld", BaseURLString, (long)self.loadingPage];
}

- (void)setupDataWithResponseArray:(NSArray *)responseArray {
	for (NSDictionary * entryDict in responseArray) {
		DataEntry *entry = [DataEntry new];
		entry.title = entryDict[@"title"];
		entry.imagePath = [NSString stringWithFormat:@"%@%@", BaseURLString, entryDict[@"path"]];
		entry.imageHeight = 100;
		[self.dataEntries[HotDataKey] addObject:entry];
	}
}

- (void)loadMore {
	if (self.currentPage == self.loadingPage) {
		self.loadingPage++;
		[self retrieveData];
	}
}

- (void)resetData {
	self.currentPage = -1;
	self.loadingPage = 1;
	[self.dataEntries[HotDataKey] removeAllObjects];
}

@end
