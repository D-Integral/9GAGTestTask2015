//
//  DataManager.h
//  9GAG
//
//  Created by Dmytro Skorokhod on 9/13/15.
//  Copyright (c) 2015 Dima Skorokhod. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataManagerDelegate <NSObject>

- (void)dataRetrieved;

@end

@interface DataManager : NSObject

@property (nonatomic, retain) NSArray *dataEntries;
@property (nonatomic, weak) id<DataManagerDelegate> delegate;

+ (id)sharedManager;

- (void)retrieveData;

@end
