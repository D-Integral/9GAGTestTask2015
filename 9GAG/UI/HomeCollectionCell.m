//
//  HomeCollectionCell.m
//  9GAG
//
//  Created by Dmytro Skorokhod on 9/13/15.
//  Copyright (c) 2015 Dima Skorokhod. All rights reserved.
//

#import "HomeCollectionCell.h"

#import "UIImageView+WebCache.h"

#import "DataEntry.h"

@interface HomeCollectionCell ()

@end

@implementation HomeCollectionCell

- (void)setupWithDataEntry:(DataEntry *)dataEntry {
	self.titleLabel.text = dataEntry.title;
	
	NSURL *url = [NSURL URLWithString:dataEntry.imagePath];
	[self.funPicture sd_setImageWithURL:url];
	
//	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
//				   ^{
//					   NSURL *url = [NSURL URLWithString:dataEntry.imagePath];
//					   NSData *data = [NSData dataWithContentsOfURL:url];
//					   UIImage *image = [UIImage imageWithData:data];
//					   dispatch_async(dispatch_get_main_queue(),
//									  ^{
//										  [self updatePicture:image];
//									  });
//	});
}

- (void)updatePicture:(UIImage *)image {
	self.funPicture.image = image;
}

@end
