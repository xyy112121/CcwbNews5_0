//
//  ARVideoViewController.m
//  CcwbNews5_0
//
//  Created by xyy520 on 17/6/1.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ARVideoViewController.h"

@interface ARVideoViewController ()

@end

@implementation ARVideoViewController


- (void)loadView {
	self.glView = [[OpenGLView alloc] initWithFrame:CGRectZero];
	self.view = self.glView;
}

- (void)viewDidLoad {
	[super viewDidLoad];
//	self.glView = [[OpenGLView alloc] initWithFrame:CGRectZero];
//	self.view = self.glView;
	[self.glView setOrientation:self.interfaceOrientation];
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	
	[self.glView start];
}

- (void)viewWillDisappear:(BOOL)animated{
	[super viewWillAppear:animated];
	[self.glView stop];
}

-(void)viewWillLayoutSubviews{
	[super viewWillLayoutSubviews];
	[self.glView resize:self.view.bounds orientation:self.interfaceOrientation];
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duratio
{
	[self.glView setOrientation:toInterfaceOrientation];
}

@end
