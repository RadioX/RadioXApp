//
//  DetailViewController.m
//  RadioX
//
//  Created by witawat wanamonthon on 10/20/12.
//  Copyright (c) 2012 witawat wanamonthon. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize viewContent,textString;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIImage *image = [UIImage imageNamed: @"logo.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: image];
    [self.logoOutlet setTitleView:imageView];
    self.viewContent.text = textString;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)backButtonPress:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
