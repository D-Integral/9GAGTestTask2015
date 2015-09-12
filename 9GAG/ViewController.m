//
//  ViewController.m
//  9GAG
//
//  Created by Dmytro Skorokhod on 9/12/15.
//  Copyright (c) 2015 Dmytro Skorokhod. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self setupNavigationBar];
	[self highlightSelectedSegment];
}

- (IBAction)segmentChanged:(id)sender {
	[self highlightSelectedSegment];
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

@end
