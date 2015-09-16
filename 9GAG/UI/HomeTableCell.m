//
//  HomeTableCell.m
//  9GAG
//
//  Created by Dmytro Skorokhod on 9/13/15.
//  Copyright (c) 2015 Dima Skorokhod. All rights reserved.
//

#import "HomeTableCell.h"

#import "UIImageView+WebCache.h"

#import "DataEntry.h"

@implementation HomeTableCell

- (void)setupWithDataEntry:(DataEntry *)dataEntry {
	self.titleLabel.text = dataEntry.title;
	
	NSURL *url = [NSURL URLWithString:dataEntry.imagePath];
	[self.funPicture sd_setImageWithURL:url];
}

@end
