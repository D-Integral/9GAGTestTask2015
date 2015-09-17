//
//  HomeTableCell.h
//  9GAG
//
//  Created by Dmytro Skorokhod on 9/13/15.
//  Copyright (c) 2015 Dima Skorokhod. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataEntry;
@class DFImageView;

@interface HomeTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet DFImageView *funPicture;

- (void)setupWithDataEntry:(DataEntry *)dataEntry;

@end
