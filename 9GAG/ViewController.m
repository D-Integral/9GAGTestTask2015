//
//  ViewController.m
//  9GAG
//
//  Created by Dmytro Skorokhod on 9/12/15.
//  Copyright (c) 2015 Dmytro Skorokhod. All rights reserved.
//

#import "ViewController.h"

#import "HomeTableCell.h"
#import "HorizontalScrollableCell.h"
#import "HomeCollectionCell.h"

#import "DataManager.h"
#import "DataEntry.h"

NSInteger const HorizontalScrollableSection = 0;

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, DataManagerDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self startDataRetrieving];
	[self setupNavigationBar];
	[self highlightSelectedSegment];
}

#pragma mark -

- (IBAction)segmentChanged:(id)sender {
	[self highlightSelectedSegment];
	[self.tableView reloadData];
}

#pragma mark -

- (void)startDataRetrieving {
	DataManager *sharedDataManager = [DataManager sharedManager];
	sharedDataManager.delegate = self;
	[sharedDataManager retrieveData];
}

#pragma mark -
#pragma mark Navigation Bar

- (void)setupNavigationBar {
	[self makeNavigationBarTranslucent];
	
	self.navigationController.navigationBar.topItem.title = NSLocalizedString(@"9GAG", @"9GAG");
	self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
}

- (void)makeNavigationBarTranslucent {
	[self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
	self.navigationController.navigationBar.shadowImage = [UIImage new];
	self.navigationController.navigationBar.translucent = YES;
}

#pragma mark -
#pragma mark Segmented Control

- (void)highlightSelectedSegment {
	for (NSInteger i = 0; i < [self.segmentedControl.subviews count]; i++) {
		UIColor *color = [[self.segmentedControl.subviews objectAtIndex:i] isSelected] ? [UIColor whiteColor] : [self nonSelectedSegmentColor];
		[[self.segmentedControl.subviews objectAtIndex:i] setTintColor:color];
	}
}

- (UIColor *)nonSelectedSegmentColor {
	return [UIColor colorWithRed:0.5195 green:0.5195 blue:0.5195 alpha:1.0];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 2;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
	return HorizontalScrollableSection == section ? 1 : 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	return HorizontalScrollableSection == indexPath.section ? [self horizontalScrollableCell] : [self standardHomeTableCell];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return HorizontalScrollableSection == indexPath.section ? 160.0f : [self heightForStandardHomeCellWithIndex:indexPath.row];
}

- (CGFloat)heightForStandardHomeCellWithIndex:(NSInteger)index {
	UIImage *image = [UIImage imageNamed:[self imageNames][self.segmentedControl.selectedSegmentIndex]];
	return image.size.height + 45.0f;
}

#pragma mark -

- (HorizontalScrollableCell *)horizontalScrollableCell {
	HorizontalScrollableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"HorizontalScrollableCell"];
	cell.collectionView.dataSource = self;
	cell.collectionView.delegate = self;
	[cell.collectionView reloadData];
	
	return cell;
}

-(HomeTableCell *)standardHomeTableCell {
	HomeTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"HomeTableCell"];
	
	cell.funPicture.image = [UIImage imageNamed:[self imageNames][self.segmentedControl.selectedSegmentIndex]];
	cell.titleLabel.text = [self imageNames][self.segmentedControl.selectedSegmentIndex];
	
	return cell;
}

- (NSArray *)imageNames {
	return @[@"Hot", @"Trending", @"Fresh"];
}

#pragma mark -
#pragma mark UITableViewDelegate

#pragma mark -
#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
	 numberOfItemsInSection:(NSInteger)section {
	return [[[DataManager sharedManager] dataEntries] count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
				  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	HomeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCollectionCell" forIndexPath:indexPath];
	
	[cell setupWithDataEntry:[self dataEntryAtIndex:indexPath.row]];
	
	return cell;
}

- (DataEntry *)dataEntryAtIndex:(NSInteger)index {
	return [[[DataManager sharedManager] dataEntries] objectAtIndex:index];
}

#pragma mark -
#pragma mark UICollectionViewDelegate

#pragma mark -
#pragma mark DataManagerDelegate

- (void)dataRetrieved {
	[self.tableView reloadData];
}

@end
