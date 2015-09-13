//
//  HomeCollectionCell.h
//  9GAG
//
//  Created by Dmytro Skorokhod on 9/13/15.
//  Copyright (c) 2015 Dima Skorokhod. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataEntry;

@interface HomeCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *funPicture;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (void)setupWithDataEntry:(DataEntry *)dataEntry;

@end
