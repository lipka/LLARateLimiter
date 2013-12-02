//
//  LLAExampleViewController.m
//  LLARateLimiter
//
//  Created by Lukas Lipka on 11/11/13.
//  Copyright (c) 2013 Lukas Lipka. All rights reserved.
//

#import "LLAExampleViewController.h"
#import "LLAPersistentRateLimiter.h"

@interface LLAExampleViewController ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *button;

@end

@implementation LLAExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.label = [[UILabel alloc] initWithFrame:CGRectZero];
    self.label.frame = CGRectMake(0, 20.0f, self.view.bounds.size.width, 60.0f);
    self.label.text = NSLocalizedString(@"Not executed", nil);
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.label];
    
    self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.button.frame = CGRectMake(0, 80.0f, self.view.bounds.size.width, 40.0f);
    [self.button setTitle:NSLocalizedString(@"Execute", nil) forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(execute:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
}

- (void)execute:(id)sender {
    [LLARateLimiter executeBlock:^{
        self.label.text = [[NSDate date] description];
    } name:@"execute" limit:30];
}

@end
