//
//  HomeTableCell.m
//  9GAG
//
//  Created by Dmytro Skorokhod on 9/13/15.
//  Copyright (c) 2015 Dima Skorokhod. All rights reserved.
//

#import "HomeTableCell.h"

#import <DFImageManagerKit.h>

#import "DataEntry.h"

@implementation HomeTableCell

- (void)setupWithDataEntry:(DataEntry *)dataEntry {
	self.titleLabel.text = dataEntry.title;
	
	NSURL *url = [NSURL URLWithString:dataEntry.imagePath];
	[self.funPicture setImageWithRequest:[DFImageRequest requestWithResource:url]];
}

- (void)prepareForReuse {
	[super prepareForReuse];
	
	[self.funPicture prepareForReuse];
}

- (void)setImageWithRequest:(DFImageRequest *)request {
	[self.funPicture setImageWithRequest:request];
}

@end
