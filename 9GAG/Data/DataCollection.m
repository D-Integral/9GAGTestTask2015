//
//  DataCollection.m
//  9GAG
//
//  Created by Dmytro Skorokhod on 9/17/15.
//  Copyright © 2015 Dima Skorokhod. All rights reserved.
//

#import "DataCollection.h"

#import <AFNetworking.h>

#import "DataEntry.h"

static NSString * const BaseURLString = @"http://dm.arcana.com.ua/";

@implementation DataCollection

+ (DataCollection *)collectionWithKey:(NSString *)key
							 delegate:(id<DataCollectionDelegate>)delegate {
	DataCollection *collection = [DataCollection new];
	collection.key = key;
	collection.delegate = delegate;
	collection.currentPage = -1;
	collection.loadingPage = 1;
	collection.entries = [NSMutableArray array];
	
	return collection;
}

- (void)retrieveData
{
	NSURL *url = [NSURL URLWithString:[self dataPath]];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	
	AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
	operation.responseSerializer = [AFJSONResponseSerializer serializer];
	
	[operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
		[self setupDataWithResponseArray:(NSArray *)responseObject];
		self.currentPage = self.loadingPage;
		[self.delegate dataRetrievedForCollection:self];
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		NSLog(@"Error Retrieving Data: %@", [error localizedDescription]);
	}];
	
	[operation start];
}

- (NSString *)dataPath {
	return [NSString stringWithFormat:@"%@api/image/?limit=10&page=%ld", BaseURLString, (long)self.loadingPage];
}

- (void)setupDataWithResponseArray:(NSArray *)responseArray {
	for (NSDictionary * entryDict in responseArray) {
		DataEntry *entry = [DataEntry new];
		entry.title = entryDict[@"title"];
		entry.imagePath = [NSString stringWithFormat:@"%@%@", BaseURLString, entryDict[@"path"]];
		entry.imageHeight = 100;
		[self.entries addObject:entry];
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
	[self.entries removeAllObjects];
}

@end
