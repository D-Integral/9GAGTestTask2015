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

@implementation DataManager

+ (id)sharedManager {
	static DataManager *sharedManager = nil;
	static dispatch_once_t onceToken;
	
	dispatch_once(&onceToken, ^{
		sharedManager = [[self alloc] init];
	});
	
	return sharedManager;
}

- (void)retrieveData
{
	NSURL *url = [NSURL URLWithString:[self allDataPath]];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	
	AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
	operation.responseSerializer = [AFJSONResponseSerializer serializer];
	
	[operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
		[self setupDataWithResponseArray:(NSArray *)responseObject];
		[self.delegate dataRetrieved];
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		
		NSLog(@"Error Retrieving Data: %@", [error localizedDescription]);
	}];
	
	[operation start];
}

- (NSString *)allDataPath {
	return [NSString stringWithFormat:@"%@api/image/", BaseURLString];
}

- (void)setupDataWithResponseArray:(NSArray *)responseArray {
	NSMutableArray *dataEntries = [NSMutableArray array];
	
	for (NSDictionary * entryDict in responseArray) {
		DataEntry *entry = [DataEntry new];
		entry.title = entryDict[@"title"];
		entry.imagePath = [NSString stringWithFormat:@"%@%@", BaseURLString, entryDict[@"path"]];
		[dataEntries addObject:entry];
	}
	
	self.dataEntries = dataEntries;
}

@end
