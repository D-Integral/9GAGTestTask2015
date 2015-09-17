//
//  DataCollection.h
//  9GAG
//
//  Created by Dmytro Skorokhod on 9/17/15.
//  Copyright © 2015 Dima Skorokhod. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DataCollection;

@protocol DataCollectionDelegate <NSObject>

- (void)dataRetrievedForCollection:(DataCollection *)collection;

@end

@interface DataCollection : NSObject

@property (nonatomic, weak) id<DataCollectionDelegate> delegate;
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSMutableArray *entries;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger loadingPage;

+ (DataCollection *)collectionWithKey:(NSString *)key
							 delegate:(id<DataCollectionDelegate>)delegate;

- (void)retrieveData;
- (void)loadMore;

@end
